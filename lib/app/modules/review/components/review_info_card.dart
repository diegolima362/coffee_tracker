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
        title: Text(
          Format.capitalString(review.restaurantName),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          Format.date(review.visitDate),
          style: Theme.of(context).textTheme.bodyText2,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              review.rate.toStringAsFixed(1),
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(width: 3),
            Icon(
              Icons.star,
              color: Theme.of(context).textTheme.caption.color,
              size: 12,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
