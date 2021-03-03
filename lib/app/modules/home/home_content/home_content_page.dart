import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'components/carousel.dart';
import 'components/last_reviews.dart';
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
    final height = MediaQuery.of(context).size.height;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.05,
              left: 8,
              bottom: height * 0.01,
            ),
            child: Text(
              'Restaurantes Favoritos',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          FavoritesCarousel(
            controller: controller,
            height: height * .25,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.05,
              left: 8,
              bottom: height * 0.01,
            ),
            child: Text(
              'Ultimas Reviews',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: LastReviews(
              controller: controller,
              height: screenSize.height * .25,
            ),
          ),
        ],
      ),
    );
  }
}
