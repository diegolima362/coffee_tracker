import 'package:coffee_tracker/app/modules/review/components/review_info_card.dart';
import 'package:coffee_tracker/app/shared/components/empty_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../home_content_controller.dart';

class LastReviews extends StatelessWidget {
  const LastReviews({
    Key key,
    @required this.controller,
    this.height,
  }) : super(key: key);

  final HomeContentController controller;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? double.infinity,
      child: Observer(
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
                return ReviewInfoCard(
                  review: review,
                  onTap: () => controller.showReviewsDetails(review),
                );
              },
            );
          }
        },
      ),
    );
  }
}
