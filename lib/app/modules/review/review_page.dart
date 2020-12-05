import 'package:coffee_tracker/app/modules/review/sort_by.dart';
import 'package:coffee_tracker/app/shared/components/empty_content.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/material.dart';
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
        padding: EdgeInsets.all(8),
        itemCount: controller.reviews.length,
        itemBuilder: (context, index) {
          final item = controller.reviews[index];
          return GestureDetector(
            onTap: () => controller.showDetails(review: item),
            child: Card(
              margin: EdgeInsets.only(bottom: 5),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 4,
                ),
                title: Text('${item.restaurantName}'),
                subtitle: Text(Format.date(item.reviewDate)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${item.rate}'),
                    SizedBox(width: 2),
                    Icon(Icons.star, size: 16),
                  ],
                ),
              ),
            ),
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
      await controller.addReview();
    }
  }
}
