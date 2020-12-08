import 'package:coffee_tracker/app/modules/review/components/review_info_card.dart';
import 'package:coffee_tracker/app/modules/review/sort_by.dart';
import 'package:coffee_tracker/app/shared/components/empty_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'review_controller.dart';

class ReviewPage extends StatefulWidget {
  final String title;

  const ReviewPage({Key key, this.title = "Reviews"}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends ModularState<ReviewPage, ReviewController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: controller.searchDelegate,
              );
            },
          ),
          buildPopupMenuButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar Review',
        child: Icon(Icons.add),
        onPressed: _addReview,
      ),
      body: Observer(
        builder: _buildContent,
      ),
    );
  }

  Widget buildPopupMenuButton() {
    return PopupMenuButton<SortBy>(
      icon: Icon(Icons.sort_sharp),
      onSelected: (value) => controller.sortBy(value),
      itemBuilder: (BuildContext context) {
        final choices = ['Restaurante', 'Nota', 'Data'];
        return choices.map((String choice) {
          return PopupMenuItem<SortBy>(
            value: SortBy.values[choices.indexOf(choice)],
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    if (controller.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (controller.reviews.isEmpty) {
      return EmptyContent(
        title: 'Nada por aqui',
        message: 'Sem Reviews Registradas',
      );
    } else {
      return ListView.builder(
        itemCount: controller.reviews.length,
        itemBuilder: (context, index) {
          final review = controller.reviews[index];
          return ReviewInfoCard(
            review: review,
            onTap: () => controller.showDetails(review: review),
          );
        },
      );
    }
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
