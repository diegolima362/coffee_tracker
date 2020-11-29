import 'package:coffee_tracker/app/modules/restaurant/components/restaurant_info_card.dart';
import 'package:coffee_tracker/app/shared/components/empty_content.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_content_controller.dart';

class HomeContentPage extends StatefulWidget {
  final String title;

  const HomeContentPage({Key key, this.title = "HomeContent"})
      : super(key: key);

  @override
  _HomeContentPageState createState() => _HomeContentPageState();
}

class _HomeContentPageState
    extends ModularState<HomeContentPage, HomeContentController> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final portrait = height > width;
    final screenSize = MediaQuery.of(context).size;

    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(
              'Restaurantes Favoritos',
              style: textStyle,
            ),
            SizedBox(height: screenSize.height * .015),
            Container(
              child: _buildFavorites(),
              height: height * (portrait ? .2 : .3),
            ),
            SizedBox(height: 10),
            Text(
              'Ultimas Reviews',
              style: textStyle,
            ),
            SizedBox(height: screenSize.height * .015),
            Container(
              child: _buildLastReviews(),
              height: screenSize.height * .45,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavorites() {
    return Observer(
      builder: (BuildContext context) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        final portrait = height > width;
        final _length = controller.restaurants.length;

        if (controller.loadingRestaurants) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.restaurants.isEmpty) {
          return EmptyContent(
            title: 'Nada por aqui',
            message: 'Sem Restaurantes registrados!',
          );
        } else {
          return ListView.builder(
            itemCount: _length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final restaurant = controller.restaurants[index];
              return RestaurantInfoCard(
                mediaCache: controller.mediaCache,
                restaurant: restaurant,
                height: (portrait ? height : width) / 4,
                width: (portrait ? width : height) / 3,
                onTap: () => controller.showRestaurantDetails(restaurant),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildLastReviews() {
    return Observer(
      builder: (_) {
        final reviews = controller.reviews;
        final _length = reviews.length;
        if (controller.loadingReviews) {
          return Center(child: CircularProgressIndicator());
        } else if (reviews.isEmpty) {
          return EmptyContent(
            title: 'Nada por aqui',
            message: 'Sem Reviews registradas!',
          );
        } else {
          return ListView.builder(
            itemCount: _length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return GestureDetector(
                onTap: () => controller.showReviewsDetails(review),
                child: Card(
                  child: ListTile(
                    title: Text(review.restaurantName),
                    subtitle: Text(
                      Format.date(review.reviewDate),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(review.rate.toString()),
                        Icon(Icons.star, size: 12),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
