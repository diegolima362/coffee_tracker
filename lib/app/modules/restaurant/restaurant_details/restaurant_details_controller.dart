import 'package:coffee_tracker/app/modules/restaurant/restaurant_controller.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/media_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'full_screen_image.dart';

part 'restaurant_details_controller.g.dart';

@Injectable()
class RestaurantDetailsController = _RestaurantDetailsControllerBase
    with _$RestaurantDetailsController;

abstract class _RestaurantDetailsControllerBase with Store {
  _RestaurantDetailsControllerBase() {
    final RestaurantModel r = Modular.args.data;
    mediaCache = Modular.get();
    mediaCache.loadCache();

    setRestaurant(r);
  }

  MediaCache mediaCache;

  @observable
  RestaurantModel restaurant;

  @observable
  Image savedImage;

  @action
  void setRestaurant(RestaurantModel value) {
    restaurant = value;
    loadImage('${restaurant.id}.jpg');
  }

  @action
  void setFavorite(bool value) {
    restaurant.favorite = value;

    final IStorageRepository storage = Modular.get();

    storage.persistRestaurant(restaurant);

    loadImage('${restaurant.id}.jpg');
  }

  @action
  void edit() {
    Modular.to.pushNamed('restaurant/edit', arguments: restaurant);
  }

  @action
  void showFullImage() {
    Modular.to.showDialog(child: FullScreenImage(savedImage));
  }

  @action
  Future<void> delete() async {
    mediaCache.deleteRestaurantImage(
        id: restaurant.fileName, restaurantId: restaurant.id);

    final IStorageRepository storage = Modular.get();
    await storage.deleteRestaurant(restaurant.id);

    final RestaurantController controller = Modular.get();
    await controller.loadData();

    Modular.navigator.pop();
  }

  @action
  Future<void> setImage(Image value) async {
    savedImage = value;
  }

  Map<String, String> get shareData {
    final path = restaurant.fileName.isEmpty
        ? ''
        : '${mediaCache.cachePath.path}/${restaurant.fileName}';

    final name = FirebaseAuth.instance.currentUser.displayName;

    return {
      'text': restaurant.getRecommendationText(name),
      'subject': 'Recomendação de Café: ${restaurant.name}',
      'path': path,
    };
  }

  Future<void> loadImage(String fileName) async {
    if (restaurant.fileName.isEmpty) {
      setImage(Image.asset('images/no-image.png'));
    } else {
      setImage(await mediaCache.fetchRestaurantImage(
          restaurant.fileName, restaurant.id));
    }
  }

  Future<void> reload() async {
    await mediaCache.loadCache();
    await loadImage(restaurant.fileName);
  }
}
