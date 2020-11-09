import 'package:coffee_tracker/app/shared/components/list_items_builder.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'restaurant_controller.dart';

class RestaurantPage extends StatefulWidget {
  final String title;

  const RestaurantPage({Key key, this.title = "Cafés"}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState
    extends ModularState<RestaurantPage, RestaurantController> {
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
              Tab(child: Text('Favoritos')),
              Tab(child: Text('Todos')),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print('add restaurant');
          },
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Container(height: 150),
                Container(
                  height: 200,
                  child: FutureBuilder<List<RestaurantModel>>(
                    future: controller.favorites,
                    builder: (context, snapshot) {
                      return ListItemsBuilder<RestaurantModel>(
                        horizontal: true,
                        snapshot: snapshot,
                        itemBuilder: (BuildContext context, item) {
                          return Card(
                            child: Container(
                              width: 200,
                              height: 100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text('${item.name}'),
                                    subtitle: Text('${item.city}, ${item.state}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('${item.rate}'),
                                        SizedBox(width: 2),
                                        Icon(Icons.star, size: 16),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            _all(),
          ],
        ),
      ),
    );
  }

  Widget _all() {
    return FutureBuilder<List<RestaurantModel>>(
      future: controller.restaurants,
      builder: (context, snapshot) {
        return ListItemsBuilder<RestaurantModel>(
          snapshot: snapshot,
          itemBuilder: (BuildContext context, item) {
            return ListTile(
              title: Text('${item.name}'),
              subtitle: Text('${item.city}, ${item.state}'),
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
    );
  }
}
