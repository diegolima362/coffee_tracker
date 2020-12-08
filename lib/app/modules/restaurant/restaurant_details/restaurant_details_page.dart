import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share/share.dart';

import 'restaurant_details_controller.dart';

class RestaurantDetailsPage extends StatefulWidget {
  @override
  _RestaurantDetailsPageState createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState
    extends ModularState<RestaurantDetailsPage, RestaurantDetailsController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
  }

  _onShare(BuildContext context) async {
    final RenderBox box = context.findRenderObject();
    final data = controller.shareData;

    if (data['path'].isNotEmpty) {
      await Share.shareFiles([data['path']],
          text: data['text'],
          subject: data['subject'],
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(data['text'],
          subject: data['subject'],
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subTitleColor = isDark ? Colors.white70 : Colors.black54;
    final iconColor = Theme.of(context).textTheme.subtitle2.color;

    return Observer(
      builder: (_) {
        final restaurant = controller.restaurant;

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            brightness: isDark ? Brightness.dark : Brightness.light,
            backgroundColor: Theme.of(context).canvasColor,
            iconTheme: IconThemeData(color: subTitleColor),
            actions: [
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () => _onShare(context),
                color: iconColor,
              ),
              IconButton(
                icon: Icon(restaurant.favorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: iconColor,
                onPressed: () => controller.setFavorite(!restaurant.favorite),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: controller.edit,
                color: iconColor,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: controller.delete,
                color: iconColor,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * .85,
              child: Card(
                margin: EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildImage(),
                    SizedBox(height: 10),
                    Container(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.7,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(4),
                              title: Text(
                                Format.capitalString(restaurant.name),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 22),
                              ),
                              subtitle: Text(
                                '${Format.capitalString(restaurant.city)}, ${restaurant.state.toUpperCase()}',
                                style: TextStyle(fontSize: 18),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          if (restaurant.allReviews?.isNotEmpty ?? false)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    restaurant.rate.toStringAsFixed(1),
                                    style: TextStyle(
                                      fontSize: 26,
                                      color: subTitleColor,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Icon(
                                    Icons.star,
                                    size: 18,
                                    color: subTitleColor,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox(height: 1)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (restaurant.commentary?.isNotEmpty ?? false)
                            Text(
                              'Impressões: "${restaurant.commentary}"',
                              style:
                                  TextStyle(color: subTitleColor, fontSize: 14),
                            ),
                          const SizedBox(height: 5),
                          Text('Informações'),
                          const SizedBox(height: 5),
                          if (restaurant.address != null)
                            Text(
                              'Endereço: ${restaurant.address}',
                              maxLines: 2,
                              style:
                                  TextStyle(color: subTitleColor, fontSize: 14),
                            ),
                          Text(
                            'Idas ao local: ${restaurant.allReviews.length}',
                            maxLines: 2,
                            style:
                                TextStyle(color: subTitleColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage() {
    final h = MediaQuery.of(context).size.height * .4;
    final w = MediaQuery.of(context).size.width;

    final fit = BoxFit.cover;

    return controller.savedImage != null
        ? GestureDetector(
            onTap: controller.restaurant.imageURL.isNotEmpty
                ? controller.showFullImage
                : () {},
            child: Stack(
              children: [
                Container(
                  child: controller.savedImage,
                  width: w,
                  height: h,
                ),
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: w,
                    color: Colors.black,
                    height: h,
                  ),
                ),
              ],
            ),
          )
        : Image.asset(
            'images/no-image.png',
            height: h,
            fit: fit,
          );
  }
}
