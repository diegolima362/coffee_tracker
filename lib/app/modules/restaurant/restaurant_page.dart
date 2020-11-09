import 'package:coffee_tracker/app/shared/components/list_items_builder.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'components/restaurant_info_card.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('add restaurant');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: FutureBuilder<List<RestaurantModel>>(
          future: controller.allRestaurants,
          builder: (context, snapshot) {
            return ListItemsBuilder<RestaurantModel>(
              snapshot: snapshot,
              itemBuilder: (BuildContext context, item) {
                return RestaurantInfoCard(
                  restaurant: item,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.1,
                  radius:5.0,
                  expanded: true,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
