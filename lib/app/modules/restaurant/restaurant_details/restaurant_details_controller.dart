import 'dart:typed_data';

import 'package:coffee_tracker/app/modules/restaurant/restaurant_controller.dart';
import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/media_storage_repository_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'full_screen_image.dart';

part 'restaurant_details_controller.g.dart';

@Injectable()
class RestaurantDetailsController = _RestaurantDetailsControllerBase
    with _$RestaurantDetailsController;

abstract class _RestaurantDetailsControllerBase with Store {
  IMediaStorageRepository mediaStorage;

  @observable
  RestaurantModel restaurant;

  @observable
  bool favorite;

  @observable
  Uint8List savedImage;

  _RestaurantDetailsControllerBase() {
    final RestaurantModel r = Modular.args.data;
    mediaStorage = Modular.get();

    setRestaurant(r);
  }

  Map<String, String> get shareData {
    final AuthController auth = Modular.get();
    final name = auth.user.displayName ?? 'User';

    return {
      'text': restaurant.getRecommendationText(name),
      'subject': 'Recomendação de Café: ${restaurant.name}',
    };
  }

  @action
  Future<void> delete() async {
    if (!kIsWeb)
      mediaStorage.deleteRestaurantImage(
          photoId: restaurant.imageURL, restaurantId: restaurant.id);

    final IStorageRepository storage = Modular.get();
    await storage.deleteRestaurant(restaurant.id);

    final RestaurantController controller = Modular.get();
    await controller.loadData();

    Modular.navigator.pop();
  }

  void edit() {
    Modular.link.pushNamed('/edit', arguments: restaurant);
  }

  void goToHome() {
    Modular.to.popUntil(ModalRoute.withName('/home'));
  }

  void closePage() {
    Modular.to.pop();
  }

  Future<void> loadImage(String fileName) async {
    if (restaurant.imageURL.isEmpty) {
      setImage(null);
    } else {
      setImage(
        await mediaStorage.fetchRestaurantImage(
          restaurantId: restaurant.id,
          photoId: restaurant.imageURL,
        ),
      );
    }
  }

  Future<void> reload() async {
    mediaStorage.loadCache();
    await loadImage(restaurant.imageURL);
  }

  @action
  void setFavorite(bool value) {
    favorite = value;
    restaurant.favorite = value;
    Modular.get<IStorageRepository>().updateRestaurant(restaurant);
  }

  @action
  Future<void> setImage(Uint8List value) async {
    savedImage = value != null && value.isNotEmpty ? value : null;
  }

  @action
  void setRestaurant(RestaurantModel value) {
    restaurant = value;
    favorite = restaurant.favorite;
    loadImage('${restaurant.id}.jpg');
  }

  @action
  void showFullImage() {
    if (savedImage != null)
      Modular.to.showDialog(child: FullScreenImage(savedImage));
  }
}
