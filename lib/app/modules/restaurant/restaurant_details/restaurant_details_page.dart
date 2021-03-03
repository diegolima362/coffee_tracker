import 'package:coffee_tracker/app/shared/components/customDetailsPage.dart';
import 'package:coffee_tracker/app/shared/components/responsive.dart';
import 'package:coffee_tracker/app/shared/components/star_rating.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_plus/share_plus.dart';

import 'restaurant_details_controller.dart';

class RestaurantDetailsPage extends StatefulWidget {
  @override
  _RestaurantDetailsPageState createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState
    extends ModularState<RestaurantDetailsPage, RestaurantDetailsController> {
  _onShare(BuildContext context) async {
    final RenderBox box = context.findRenderObject();
    final data = controller.shareData;

    if (!kIsWeb) {
      PlatformFile file = PlatformFile(bytes: controller.savedImage);

      await Share.shareFiles(
        [file.path],
        text: data['text'],
        subject: data['subject'],
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      await Share.share(
        data['text'],
        subject: data['subject'],
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    double w = ResponsiveWidget.contentWidth(context);
    final restaurant = controller.restaurant;

    return ResponsivePage(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: _buildImage(_height * .4, w),
            height: _height * 0.4,
          ),
          _buildTitle(),
          const SizedBox(height: 20),
          _buildAddress(),
          const SizedBox(height: 10),
          if (restaurant.commentary?.isNotEmpty) _buildCommentary(),
          const SizedBox(height: 20),
          const Divider(thickness: .5),
          _buildActions(w),
        ],
      ),
    );
  }

  Center _buildCommentary() {
    return Center(
      child: Text(
        '\"${controller.restaurant.commentary}\"',
        style: Theme.of(context).textTheme.bodyText2,
        maxLines: 3,
      ),
    );
  }

  ListTile _buildAddress() {
    return ListTile(
      title: Text(
        '${Format.capitalString(controller.restaurant.city)}, ${controller.restaurant.state.toUpperCase()}',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        '${Format.capitalString(controller.restaurant.address)}',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  ListTile _buildTitle() {
    return ListTile(
      title: Text(
        Format.capitalString(controller.restaurant.name),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline5,
      ),
      subtitle: StarRating(
        rating: controller.restaurant.rate,
        iconSize: 14,
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
      Observer(
        builder: (_) => IconButton(
          icon: Icon(
            controller.favorite ? Icons.favorite : Icons.favorite_border,
          ),
          onPressed: () =>
              controller.setFavorite(!controller.restaurant.favorite),
          tooltip: 'Favoritar',
        ),
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
        child: Row(children: _actions),
      ),
    );
  }

  Widget _buildImage(double height, double width) {
    return GestureDetector(
      onTap: () => controller.showFullImage(),
      child: Observer(
        builder: (_) {
          return Container(
            child: controller.savedImage != null
                ? Image.memory(
                    controller.savedImage,
                    color: Color.fromRGBO(100, 100, 100, 1),
                    colorBlendMode: BlendMode.modulate,
                    fit: BoxFit.cover,
                    height: height,
                    width: width,
                  )
                : Image.asset(
                    'images/no-image.png',
                    color: Color.fromRGBO(100, 100, 100, 1.0),
                    colorBlendMode: BlendMode.modulate,
                    fit: BoxFit.cover,
                    height: height,
                    width: width,
                  ),
          );
        },
      ),
    );
  }
}
