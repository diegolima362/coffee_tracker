import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Color color;
  final double iconSize;

  StarRating({this.starCount = 5, this.rating = .0, this.color, this.iconSize});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;

    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        size: iconSize,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        size: iconSize,
      );
    } else {
      icon = Icon(
        Icons.star,
        size: iconSize,
      );
    }
    return InkResponse(child: icon);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...List.generate(
          starCount,
          (index) => buildStar(context, index),
        ),
        SizedBox(width: 5),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.subtitle2,
        )
      ],
    );
  }
}
