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
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(child: Text('Recentes')),
              Tab(child: Text('Todas')),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print('add review');
          },
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<ReviewModel>>(
              future: controller.last,
              builder: (context, snapshot) {
                return ListItemsBuilder<ReviewModel>(
                  snapshot: snapshot,
                  itemBuilder: (BuildContext context, item) {
                    return ListTile(
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
                    );
                  },
                );
              },
            ),
            FutureBuilder<List<ReviewModel>>(
              future: controller.reviews,
              builder: (context, snapshot) {
                return ListItemsBuilder<ReviewModel>(
                  snapshot: snapshot,
                  itemBuilder: (BuildContext context, item) {
                    return ListTile(
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
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
