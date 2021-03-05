import 'dart:typed_data';

import 'package:coffee_tracker/app/modules/restaurant/restaurant_details/restaurant_details_controller.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/media_storage_repository_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:coffee_tracker/app/utils/id_generator.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../restaurant_controller.dart';

part 'edit_controller.g.dart';

@Injectable()
class EditController = _EditControllerBase with _$EditController;

abstract class _EditControllerBase with Store {
  _EditControllerBase() {
    final RestaurantModel r = Modular.args.data;
    mediaStorage = Modular.get();

    mediaStorage.loadCache();

    setRestaurant(r);

    setImagePath(r?.imageURL?.isNotEmpty ?? false ? r.imageURL : '');

    if (r != null) {
      loadImage(r.imageURL);
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
      setImagePath('');
    }
  }

  IMediaStorageRepository mediaStorage;

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
  String imagePath;

  @computed
  bool get hasImage => imageFile != null;

  @observable
  Uint8List imageFile;

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
  void setImagePath(String value) => imagePath = value;

  @action
  void setCity(String value) => city = value;

  @action
  void setState(String value) => state = value;

  @action
  void setRestaurant(RestaurantModel value) => restaurant = value;

  @action
  Future<void> setImage(Uint8List value) async {
    imageFile = value != null && value.isNotEmpty ? value : null;
  }

  @action
  void setImageFile(Uint8List value) {
    changedImage = true;
    if (imagePath.isNotEmpty && value == null) {
      imageFile = value;
      deletedImage = true;
      setRestaurantImage = false;
      setImage(null);
      setImagePath('');
    } else {
      setRestaurantImage = true;
      imageFile = value;
      setImage(value);
      setImagePath(_id);
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
      imageURL: imagePath,
      commentary: commentary,
    );
  }

  Future<void> loadImage(String imageURL) async {
    if (imageURL.isEmpty) {
      setImagePath('');
      setImage(null);
    } else {
      mediaStorage.loadCache();

      setImage(await mediaStorage.fetchRestaurantImage(
        photoId: imageURL,
        restaurantId: restaurant.id,
      ));

      setImagePath(imageURL);
    }
  }

  @action
  Future<void> save() async {
    final IStorageRepository storage = Modular.get();

    final r = _restaurantFromState();

    if (deletedImage) {
      mediaStorage.deleteRestaurantImage(
        photoId: imagePath,
        restaurantId: _id,
      );

      r.imageURL = '';
    } else if (setRestaurantImage) {
      mediaStorage.persistRestaurantImage(
        restaurantId: _id,
        file: imageFile,
      );

      r.imageURL = _id;
    }

    if (restaurant != null) {
      final RestaurantDetailsController controller = Modular.get();

      controller.restaurant.name = r.name;
      controller.restaurant.imageURL = r.imageURL;
      controller.restaurant.city = r.city;
      controller.restaurant.state = r.state;
      controller.restaurant.address = r.address;
      controller.restaurant.commentary = r.commentary;

      await storage.updateRestaurant(r);
      await controller.reload();
    } else {
      await storage.persistRestaurant(r);
      final RestaurantController controller = Modular.get();
      await controller.loadData();
    }

    Modular.navigator.pop();
  }
}
