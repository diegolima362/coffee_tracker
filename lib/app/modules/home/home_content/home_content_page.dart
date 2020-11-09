import 'package:coffee_tracker/app/modules/restaurant/components/restaurant_info_card.dart';
import 'package:coffee_tracker/app/shared/components/list_items_builder.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:flutter/material.dart';
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
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height * .015),
            Container(
              height: screenSize.height * .02,
              child: Text(
                'Restaurantes Favoritos',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: screenSize.height * .015),
            Container(
              child: _buildFavorites(),
              height: screenSize.height * .2,
            ),
            SizedBox(height: screenSize.height * .035),
            Container(
              height: screenSize.height * .02,
              child: Text(
                'Ultimas Reviews',
                style: TextStyle(fontSize: 16),
              ),
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
    return FutureBuilder<List<RestaurantModel>>(
      future: controller.favorites,
      builder: (context, snapshot) {
        return ListItemsBuilder<RestaurantModel>(
          horizontal: true,
          snapshot: snapshot,
          itemBuilder: (BuildContext context, item) {
            return RestaurantInfoCard(
              restaurant: item,
            );
          },
        );
      },
    );
  }

  Widget _buildLastReviews() {
    return FutureBuilder<List<ReviewModel>>(
      future: controller.last,
      builder: (context, snapshot) {
        return ListItemsBuilder<ReviewModel>(
          snapshot: snapshot,
          itemBuilder: (BuildContext context, item) {
            return Card(
              margin: EdgeInsets.only(bottom: 5),
              child: ListTile(
                contentPadding: EdgeInsets.all(5),
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
    );
  }
}
