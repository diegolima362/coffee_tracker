import 'dart:io';

import 'package:coffee_tracker/app/modules/restaurant/restaurant_details/restaurant_details_controller.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/media_cache.dart';
import 'package:coffee_tracker/app/utils/id_generator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../restaurant_controller.dart';

part 'edit_controller.g.dart';

@Injectable()
class EditController = _EditControllerBase with _$EditController;

abstract class _EditControllerBase with Store {
  _EditControllerBase() {
    final RestaurantModel r = Modular.args.data;
    mediaCache = Modular.get();

    mediaCache.loadCache();

    setRestaurant(r);

    setFileName(r?.fileName?.isNotEmpty ?? false ? r.fileName : '');

    if (r != null) {
      loadImage(r.fileName);
      setName(r.name);
      setCity(r.city);
      setAddress(r.address);
      setState(r.state);
      setCommentary(r.commentary ?? '');
      _id = restaurant.id;
      _registerDate = restaurant.registerDate;
    } else {
      _registerDate = DateTime.now();
      _id = IdGenerator.documentIdFromCurrentDate();
      setFileName('');
    }
  }

  MediaCache mediaCache;

  String _id;
  DateTime _registerDate;

  bool changedImage = false;
  bool setRestaurantImage = false;
  bool deletedImage = false;

  @computed
  bool get canSave {
    return (name?.isNotEmpty ?? false) &&
        (city?.isNotEmpty ?? false) &&
        (state?.isNotEmpty ?? false);
  }

  @observable
  Image savedImage;

  @observable
  String fileName;

  @computed
  bool get hasImage => imageFile != null || fileName.isNotEmpty;

  @observable
  File imageFile;

  @observable
  RestaurantModel restaurant;

  @observable
  String name;

  @observable
  String commentary;

  @observable
  String address;

  @observable
  String city;

  @observable
  String state;

  @action
  void setName(String value) => name = value;

  @action
  void setCommentary(String value) => commentary = value;

  @action
  void setAddress(String value) => address = value;

  @action
  void setFileName(String value) => fileName = value;

  @action
  void setCity(String value) => city = value;

  @action
  void setState(String value) => state = value;

  @action
  void setRestaurant(RestaurantModel value) => restaurant = value;

  @action
  Future<void> setImage(Image value) async {
    savedImage = value;
  }

  @action
  void setImageFile(File value) {
    changedImage = true;
    if (fileName.isNotEmpty && value == null) {
      imageFile = value;
      deletedImage = true;
      setRestaurantImage = false;
      setImage(Image.asset('images/no-image.png'));
      setFileName('');
    } else {
      setRestaurantImage = true;
      imageFile = value;
      setImage(Image.file(value));
      setFileName(_id + '.jpg');
    }
  }

  @action
  RestaurantModel _restaurantFromState() {
    return RestaurantModel(
      id: _id,
      registerDate: _registerDate,
      name: name,
      city: city,
      address: address,
      state: state,
      favorite: restaurant?.favorite ?? false,
      fileName: fileName,
      commentary: commentary,
    );
  }

  Future<void> loadImage(String url) async {
    if (url.isEmpty) {
      setFileName('');
      setImage(Image.asset('images/no-image.png'));
    } else {
      await mediaCache.loadCache();
      setImage(await mediaCache.fetchRestaurantImage(url, restaurant.id));
      setFileName(url);
    }
  }

  @action
  Future<void> save() async {
    final IStorageRepository storage = Modular.get();

    final r = _restaurantFromState();

    if (deletedImage) {
      mediaCache.deleteRestaurantImage(
        id: fileName,
        restaurantId: _id,
      );
      r.fileName = '';
    } else if (setRestaurantImage) {
      mediaCache.addRestaurantImage(
        restaurantId: _id,
        id: _id + '.jpg',
        file: imageFile,
      );
      r.fileName = _id + '.jpg';
      mediaCache.synchronize();
    }

    if (restaurant != null) {
      final RestaurantDetailsController controller = Modular.get();

      controller.restaurant.name = r.name.trim();
      controller.restaurant.fileName = r.fileName.trim();
      controller.restaurant.city = r.city.trim();
      controller.restaurant.state = r.state.trim();
      controller.restaurant.address = r.address.trim();
      controller.restaurant.commentary = r.commentary.trim();

      await storage.persistRestaurant(r);
      controller.reload();
    } else {
      await storage.persistRestaurant(r);
      final RestaurantController controller = Modular.get();
      await controller.loadData();
    }

    print(r.fileName);

    Modular.navigator.pop();
  }
}
