// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $EditController = BindInject(
  (i) => EditController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditController on _EditControllerBase, Store {
  Computed<bool> _$canSaveComputed;

  @override
  bool get canSave => (_$canSaveComputed ??= Computed<bool>(() => super.canSave,
          name: '_EditControllerBase.canSave'))
      .value;
  Computed<bool> _$hasImageComputed;

  @override
  bool get hasImage =>
      (_$hasImageComputed ??= Computed<bool>(() => super.hasImage,
              name: '_EditControllerBase.hasImage'))
          .value;

  final _$savedImageAtom = Atom(name: '_EditControllerBase.savedImage');

  @override
  Image get savedImage {
    _$savedImageAtom.reportRead();
    return super.savedImage;
  }

  @override
  set savedImage(Image value) {
    _$savedImageAtom.reportWrite(value, super.savedImage, () {
      super.savedImage = value;
    });
  }

  final _$imagePathAtom = Atom(name: '_EditControllerBase.imagePath');

  @override
  String get imagePath {
    _$imagePathAtom.reportRead();
    return super.imagePath;
  }

  @override
  set imagePath(String value) {
    _$imagePathAtom.reportWrite(value, super.imagePath, () {
      super.imagePath = value;
    });
  }

  final _$imageFileAtom = Atom(name: '_EditControllerBase.imageFile');

  @override
  File get imageFile {
    _$imageFileAtom.reportRead();
    return super.imageFile;
  }

  @override
  set imageFile(File value) {
    _$imageFileAtom.reportWrite(value, super.imageFile, () {
      super.imageFile = value;
    });
  }

  final _$restaurantAtom = Atom(name: '_EditControllerBase.restaurant');

  @override
  RestaurantModel get restaurant {
    _$restaurantAtom.reportRead();
    return super.restaurant;
  }

  @override
  set restaurant(RestaurantModel value) {
    _$restaurantAtom.reportWrite(value, super.restaurant, () {
      super.restaurant = value;
    });
  }

  final _$nameAtom = Atom(name: '_EditControllerBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$commentaryAtom = Atom(name: '_EditControllerBase.commentary');

  @override
  String get commentary {
    _$commentaryAtom.reportRead();
    return super.commentary;
  }

  @override
  set commentary(String value) {
    _$commentaryAtom.reportWrite(value, super.commentary, () {
      super.commentary = value;
    });
  }

  final _$addressAtom = Atom(name: '_EditControllerBase.address');

  @override
  String get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  final _$cityAtom = Atom(name: '_EditControllerBase.city');

  @override
  String get city {
    _$cityAtom.reportRead();
    return super.city;
  }

  @override
  set city(String value) {
    _$cityAtom.reportWrite(value, super.city, () {
      super.city = value;
    });
  }

  final _$stateAtom = Atom(name: '_EditControllerBase.state');

  @override
  String get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(String value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$setImageAsyncAction = AsyncAction('_EditControllerBase.setImage');

  @override
  Future<void> setImage(Image value) {
    return _$setImageAsyncAction.run(() => super.setImage(value));
  }

  final _$saveAsyncAction = AsyncAction('_EditControllerBase.save');

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  final _$_EditControllerBaseActionController =
      ActionController(name: '_EditControllerBase');

  @override
  void setName(String value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCommentary(String value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setCommentary');
    try {
      return super.setCommentary(value);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddress(String value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setAddress');
    try {
      return super.setAddress(value);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setImagePath(String value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setImagePath');
    try {
      return super.setImagePath(value);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCity(String value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setCity');
    try {
      return super.setCity(value);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setState(String value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRestaurant(RestaurantModel value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setRestaurant');
    try {
      return super.setRestaurant(value);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setImageFile(File value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setImageFile');
    try {
      return super.setImageFile(value);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  RestaurantModel _restaurantFromState() {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase._restaurantFromState');
    try {
      return super._restaurantFromState();
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
savedImage: ${savedImage},
imagePath: ${imagePath},
imageFile: ${imageFile},
restaurant: ${restaurant},
name: ${name},
commentary: ${commentary},
address: ${address},
city: ${city},
state: ${state},
canSave: ${canSave},
hasImage: ${hasImage}
    ''';
  }
}
