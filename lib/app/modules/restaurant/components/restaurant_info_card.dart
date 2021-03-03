import 'dart:typed_data';

import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/media_storage_repository_interface.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/foundation.dart';
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
  final IMediaStorageRepository mediaStorage;
  final void Function() onTap;

  const RestaurantInfoCard({
    Key key,
    @required this.restaurant,
    this.mediaStorage,
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
    return GestureDetector(
      onTap: onTap,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          width: width,
          height: height,
          child: expanded
              ? _buildExpandedCard(context)
              : _buildCompactCard(context),
        ),
      ),
    );
  }

  Widget _buildCompactCard(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: _buildImage(),
        ),
        _buildTitle(context),
      ],
    );
  }

  Widget _buildExpandedCard(BuildContext context) {
    return Row(
      children: [
        Container(
          width: width * .4,
          child: _buildImage(),
        ),
        const SizedBox(width: 10),
        _text(context),
      ],
    );
  }

  Widget _text(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        if (restaurant.allReviews?.isNotEmpty ?? false)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                restaurant.rate.toStringAsFixed(1),
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(width: 2.0),
              Icon(
                Icons.star,
                color: Theme.of(context).textTheme.caption.color,
                size: 12,
              ),
            ],
          ),
        SizedBox(height: 10),
        Text(
          Format.capitalString(restaurant.name),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 10),
        Text(
          '${Format.capitalString(restaurant.city)}, ${restaurant.state.toUpperCase()}',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            Format.capitalString(restaurant.name),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            '${Format.capitalString(restaurant.city)}, ${restaurant.state.toUpperCase()}',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (restaurant.imageURL.isEmpty) {
      return _noImage();
    }

    return FutureBuilder<Uint8List>(
      future: mediaStorage.fetchRestaurantImage(
        restaurantId: restaurant.id,
        photoId: restaurant.imageURL,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          return Image.memory(
            snapshot.data,
            fit: BoxFit.cover,
            width: width,
            height: height,
            color: Color.fromRGBO(100, 100, 100, 1),
            colorBlendMode: BlendMode.modulate,
          );
        } else {
          return _noImage();
        }
      },
    );
  }

  Widget _noImage() {
    return Image.asset(
      'images/no-image.png',
      fit: BoxFit.cover,
      color: Color.fromRGBO(100, 100, 100, 1),
      width: width,
      height: height,
      colorBlendMode: BlendMode.modulate,
    );
  }
}
