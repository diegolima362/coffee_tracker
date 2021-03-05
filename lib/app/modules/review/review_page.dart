import 'package:coffee_tracker/app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'components/review_info_card.dart';
import 'review_controller.dart';
import 'sort_by.dart';

class ReviewPage extends StatefulWidget {
  final String title;

  const ReviewPage({Key key, this.title = "Reviews"}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends ModularState<ReviewPage, ReviewController> {
  //use 'controller' variable to access controller

  bool _isSmall;

  @override
  Widget build(BuildContext context) {
    _isSmall = ResponsiveWidget.isSmallScreen(context);

    return Scaffold(
      floatingActionButton: _isSmall ? _buildFAB() : null,
      body: Observer(
        builder: (_) => Column(
          children: [
            _buildActionBar(),
            Expanded(child: _buildContent(_)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (controller.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (controller.reviews.isEmpty) {
      return EmptyContent(
        title: 'Nada por aqui',
        message: 'Sem Reviews Registradas!',
      );
    } else {
      final reviews = controller.reviews
          .where((r) => r
              .toString()
              .toLowerCase()
              .contains(controller.filter.toLowerCase()))
          .toList();

      final _length = reviews.length + 1;

      return ListView.builder(
        itemCount: _length,
        itemBuilder: (context, index) {
          if (_length == 1 && index == 0)
            return Center(child: Text('Sem resultados'));

          if (index == _length - 1) return SizedBox(height: 75.0);

          final review = reviews[index];

          return ReviewInfoCard(
            review: review,
            onTap: () {
              FocusScope.of(context).unfocus();
              controller.showDetails(review);
            },
          );
        },
      );
    }
  }

  Widget _buildActionBar() {
    return Card(
      child: Row(
        mainAxisAlignment: _isSmall
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.spaceEvenly,
        children: [
          if (!_isSmall) CustomAddButton(onTap: _addReview),
          SearchBar(onChanged: controller.setFilter),
          OrderBy(
            choices: ['Restaurante', 'Nota', 'Data'],
            values: SortBy.values,
            onSelected: controller.sortBy,
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      heroTag: 'add-review',
      tooltip: 'Adicionar Review',
      onPressed: _addReview,
      child: _isSmall ? Icon(Icons.add) : Text('Adicionar Review'),
      isExtended: true,
    );
  }

  Future<void> _addReview() async {
    if (!await controller.hasRestaurants) {
      final snackBar = SnackBar(
        content: Text(
          'Sem Restaurantes registrados',
          style: TextStyle(color: Theme.of(context).backgroundColor),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).accentColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      try {
        await controller.addReview();
      } on PlatformException {
        final snackBar = SnackBar(
          content: Text(
            'Sem conexão com a internet',
            style: TextStyle(color: Theme.of(context).backgroundColor),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).accentColor,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        print(e);
      }
    }
  }
}
