import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'restaurant_detail_controller.dart';

class RestaurantDetailPage extends StatefulWidget {
  final RestaurantModel restaurant;

  const RestaurantDetailPage({Key key, @required this.restaurant})
      : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState
    extends ModularState<RestaurantDetailPage, RestaurantDetailController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.restaurant = widget.restaurant;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final subTitleColor = isDark ? Colors.white70 : Colors.black54;

    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          brightness: isDark ? Brightness.dark : Brightness.light,
          backgroundColor: Theme.of(context).canvasColor,
          iconTheme: IconThemeData(color: subTitleColor),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image(
                  image: NetworkImage(
                    controller.restaurant.photoURL,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.7,
                      child: ListTile(
                        title: Text(
                          controller.restaurant.name,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 22),
                        ),
                        subtitle: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.locationArrow,
                              size: 12,
                              color: subTitleColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${controller.restaurant.city}, ${controller.restaurant.state}',
                              style: TextStyle(fontSize: 18),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            '${controller.restaurant.rate}',
                            style: TextStyle(
                              fontSize: 26,
                              color: subTitleColor,
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(
                            Icons.star,
                            size: 18,
                            color: subTitleColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
