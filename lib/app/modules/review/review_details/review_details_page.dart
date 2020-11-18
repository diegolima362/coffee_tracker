import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'review_details_controller.dart';

class ReviewDetailsPage extends StatefulWidget {
  const ReviewDetailsPage({Key key}) : super(key: key);

  @override
  _ReviewDetailsPageState createState() => _ReviewDetailsPageState();
}

class _ReviewDetailsPageState
    extends ModularState<ReviewDetailsPage, ReviewDetailsController> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: controller.edit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: controller.delete,
          ),
        ],
      ),
      body: Container(
        height: height * 0.7,
        padding: EdgeInsets.all(8),
        child: Observer(
          builder: (_) => Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Format.date(controller.review.reviewDate),
                        style: TextStyle(fontSize: 16),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        '${controller.review.rate}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 2),
                      Icon(Icons.star, size: 16),
                    ],
                  ),
                  Text(
                    controller.review.text,
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    controller.review.restaurantName,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
