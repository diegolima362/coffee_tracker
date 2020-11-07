import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'restaurant_controller.dart';

class RestaurantPage extends StatefulWidget {
  final String title;

  const RestaurantPage({Key key, this.title = "Restaurant"}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState
    extends ModularState<RestaurantPage, RestaurantController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
