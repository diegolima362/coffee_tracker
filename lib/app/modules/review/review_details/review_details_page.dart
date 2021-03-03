import 'package:coffee_tracker/app/shared/components/components.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_plus/share_plus.dart';

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

    await Share.share(
      data['text'],
      subject: data['subject'],
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = ResponsiveWidget.contentWidth(context);
    final review = controller.review;

    return ResponsivePage(
      body: Observer(
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            const SizedBox(height: 20),
            if (review.text?.isNotEmpty) _buildCommentary(),
            const SizedBox(height: 10),
            _buildAddress(),
            const SizedBox(height: 20),
            const Divider(thickness: .5),
            _buildActions(w),
          ],
        ),
      ),
    );
  }

  ListTile _buildTitle() {
    return ListTile(
      title: Text(
        Format.date(controller.review.reviewDate),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline5,
      ),
      subtitle: StarRating(
        rating: controller.review.rate,
        iconSize: 14,
      ),
    );
  }

  Center _buildCommentary() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          '\"${controller.review.text}\"',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }

  ListTile _buildAddress() {
    return ListTile(
      title: Text(
        '${Format.capitalString(controller.review.restaurantName)}',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      subtitle: Text(
        '${Format.fullDate(controller.review.visitDate)}',
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  Widget _buildActions(double w) {
    final _actions = [
      IconButton(
        icon: Icon(Icons.share),
        onPressed: () => _onShare(context),
        tooltip: 'Compartilhar',
      ),
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: controller.edit,
        tooltip: 'Editar',
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: controller.delete,
        tooltip: 'Apagar',
      ),
    ];

    return Center(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: _actions,
        ),
      ),
    );
  }
}
