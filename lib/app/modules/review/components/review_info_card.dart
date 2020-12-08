import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/material.dart';

class ReviewInfoCard extends StatelessWidget {
  final ReviewModel review;
  final void Function() onTap;

  const ReviewInfoCard({Key key, this.review, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(review.restaurantName),
        subtitle: Text(Format.date(review.visitDate)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(review.rate.toString()),
            Icon(
              Icons.star,
              size: 12,
              color: Theme.of(context).textTheme.subtitle2.color,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
