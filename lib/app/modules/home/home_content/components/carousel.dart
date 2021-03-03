import 'package:coffee_tracker/app/modules/restaurant/components/restaurant_info_card.dart';
import 'package:coffee_tracker/app/shared/components/empty_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../home_content_controller.dart';

class FavoritesCarousel extends StatelessWidget {
  const FavoritesCarousel({
    Key key,
    @required this.controller,
    this.height,
  }) : super(key: key);

  final HomeContentController controller;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Observer(
        builder: (BuildContext context) {
          final _length = controller.restaurants.length;

          if (controller.loadingRestaurants) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.restaurants.isEmpty) {
            return EmptyContent(
              title: 'Nada por aqui',
              message: 'Sem Restaurantes favoritados!',
            );
          } else {
            return ListView.builder(
              itemCount: _length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final restaurant = controller.restaurants[index];
                return RestaurantInfoCard(
                  mediaStorage: controller.mediaStorage,
                  restaurant: restaurant,
                  height: height,
                  width: height,
                  onTap: () => controller.showRestaurantDetails(restaurant),
                );
              },
            );
          }
        },
      ),
    );
  }
}
