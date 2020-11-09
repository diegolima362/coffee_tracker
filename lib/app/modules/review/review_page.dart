import 'package:coffee_tracker/app/shared/components/list_items_builder.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('add review');
        },
      ),
      body: FutureBuilder<List<ReviewModel>>(
        future: controller.allReviews,
        builder: (context, snapshot) {
          return ListItemsBuilder<ReviewModel>(
            snapshot: snapshot,
            itemBuilder: (BuildContext context, item) {
              return Card(
                margin: EdgeInsets.only(bottom: 5),
                child: ListTile(
                  title: Text('${item.restaurantName}'),
                  subtitle: Text('${item.reviewDate}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${item.rate}'),
                      SizedBox(width: 2),
                      Icon(Icons.star, size: 16),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
