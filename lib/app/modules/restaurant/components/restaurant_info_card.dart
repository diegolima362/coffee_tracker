import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/media_cache.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/material.dart';

class RestaurantInfoCard extends StatelessWidget {
  final RestaurantModel restaurant;
  final double width;
  final double height;
  final Color cardColor;
  final Color overlayColor;
  final double opacity;
  final double radius;
  final bool expanded;
  final MediaCache mediaCache;
  final void Function() onTap;

  const RestaurantInfoCard({
    Key key,
    @required this.restaurant,
    @required this.mediaCache,
    this.width,
    this.height,
    this.cardColor,
    this.overlayColor = Colors.black,
    this.opacity = 0.5,
    this.radius = 10,
    this.expanded = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ratio = MediaQuery.of(context).size.aspectRatio;
    final _width =
        width ?? MediaQuery.of(context).size.width * (expanded ? 1 : 0.35);
    final _height =
        height ?? MediaQuery.of(context).size.height * (expanded ? 0.15 : 0.25);
    final textColor = expanded ? null : Colors.white;

    final _imageWidth = expanded ? _width * (_ratio > 1 ? 0.15 : 0.3) : _width;
    final _textLeftPosition = _width * .015 + (expanded ? _imageWidth : 0);

    final w = MediaQuery.of(context).size.width * .6;
    final h = MediaQuery.of(context).size.height * .4;
    final fit = BoxFit.cover;

    final subtitleColor = Theme.of(context).textTheme.subtitle2.color;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Container(
                color: overlayColor,
                width: _imageWidth,
                height: _height,
                child: restaurant.fileName != null &&
                        restaurant.fileName.isNotEmpty
                    ? buildImage()
                    : Image.asset(
                        'images/no-image.png',
                        width: w,
                        height: h,
                        fit: fit,
                      ),
              ),
            ),
            Opacity(
              opacity: opacity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Container(
                  color: overlayColor,
                  width: _imageWidth,
                  height: _height,
                ),
              ),
            ),
            Positioned(
              left: _textLeftPosition,
              bottom: _height * 0.01,
              child: Container(
                width: _imageWidth * (expanded ? 1.5 : 0.95),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Format.capitalString(restaurant.name),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: expanded ? 20 : 16,
                      ),
                    ),
                    Text(
                      '${Format.capitalString(restaurant.city)}, ${restaurant.state.toUpperCase()}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: subtitleColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            if (restaurant.allReviews?.isNotEmpty ?? false)
              Positioned(
                right: _width * 0.01,
                top: _height * 0.05,
                child: Row(
                  children: [
                    Text(
                      restaurant.rate.toStringAsFixed(1),
                      style: TextStyle(color: textColor),
                    ),
                    SizedBox(width: 3),
                    Icon(
                      Icons.star,
                      size: 16,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    if (restaurant.fileName.isEmpty) {
      return Image.asset(
        'images/no-image.png',
        fit: BoxFit.cover,
      );
    }

    return FutureBuilder<Image>(
      future:
          mediaCache.fetchRestaurantImage(restaurant.fileName, restaurant.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        } else {
          return Image.asset(
            'images/no-image.png',
            fit: BoxFit.cover,
          );
        }
      },
    );
  }
}
