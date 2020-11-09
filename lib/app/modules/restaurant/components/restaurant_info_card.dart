import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RestaurantInfoCard extends StatelessWidget {
  final RestaurantModel restaurant;
  final double width;
  final double height;
  final Color cardColor;
  final Color overlayColor;
  final double opacity;
  final double radius;
  final bool expanded;

  const RestaurantInfoCard({
    Key key,
    @required this.restaurant,
    this.width,
    this.height,
    this.cardColor,
    this.overlayColor = Colors.black,
    this.opacity = 0.5,
    this.radius = 10,
    this.expanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = width ?? MediaQuery.of(context).size.width * 0.4;
    final _height = height ?? MediaQuery.of(context).size.height * 0.2;
    final textColor = expanded ? null : Colors.white;
    final subTitleColor = expanded ? null : Colors.white70;

    return Card(
      margin: const EdgeInsets.all(2),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              color: overlayColor,
              width: expanded ? _width * 0.3 : _width,
              height: _height,
              child: Image(
                image: NetworkImage(restaurant.photoURL),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Opacity(
            opacity: opacity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Container(
                color: overlayColor,
                width: expanded ? _width * 0.3 : _width,
                height: _height,
              ),
            ),
          ),
          Positioned(
            left: _width * (expanded ? 0.31 : 0.03),
            bottom: _height * 0.03,
            width: _width,
            child: Container(
              width: expanded ? _width * 0.5 : _width * 0.8,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  '${restaurant.name}',
                  style: TextStyle(color: textColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.locationArrow,
                      size: 16,
                      color: subTitleColor,
                    ),
                    Text(
                      '${restaurant.city}, ${restaurant.state}',
                      style: TextStyle(color: subTitleColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: _width * (expanded ? 0.01 : 0.05),
            top: _height * (expanded ? 0.75 : 0.05),
            child: Row(
              children: [
                Text(
                  '${restaurant.rate}',
                  style: TextStyle(color: textColor),
                ),
                SizedBox(width: 3),
                Icon(
                  Icons.star,
                  size: 16,
                  color: subTitleColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
