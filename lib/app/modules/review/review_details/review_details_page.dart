import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share/share.dart';

import 'review_details_controller.dart';

class ReviewDetailsPage extends StatefulWidget {
  const ReviewDetailsPage({Key key}) : super(key: key);

  @override
  _ReviewDetailsPageState createState() => _ReviewDetailsPageState();
}

class _ReviewDetailsPageState
    extends ModularState<ReviewDetailsPage, ReviewDetailsController> {
  _onShare(BuildContext context) async {
    final RenderBox box = context.findRenderObject();
    final data = controller.shareData;

    await Share.share(data['text'],
        subject: data['subject'],
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _onShare(context),
          ),
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
      body: SingleChildScrollView(
        child: Container(
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
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      controller.review.text,
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 10),
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
      ),
    );
  }
}
