// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_details_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $RestaurantDetailsController = BindInject(
  (i) => RestaurantDetailsController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RestaurantDetailsController on _RestaurantDetailsControllerBase, Store {
  final _$restaurantAtom =
      Atom(name: '_RestaurantDetailsControllerBase.restaurant');

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

  final _$savedImageAtom =
      Atom(name: '_RestaurantDetailsControllerBase.savedImage');

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

  final _$deleteAsyncAction =
      AsyncAction('_RestaurantDetailsControllerBase.delete');

  @override
  Future<void> delete() {
    return _$deleteAsyncAction.run(() => super.delete());
  }

  final _$setImageAsyncAction =
      AsyncAction('_RestaurantDetailsControllerBase.setImage');

  @override
  Future<void> setImage(Image value) {
    return _$setImageAsyncAction.run(() => super.setImage(value));
  }

  final _$_RestaurantDetailsControllerBaseActionController =
      ActionController(name: '_RestaurantDetailsControllerBase');

  @override
  void setRestaurant(RestaurantModel value) {
    final _$actionInfo = _$_RestaurantDetailsControllerBaseActionController
        .startAction(name: '_RestaurantDetailsControllerBase.setRestaurant');
    try {
      return super.setRestaurant(value);
    } finally {
      _$_RestaurantDetailsControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setFavorite(bool value) {
    final _$actionInfo = _$_RestaurantDetailsControllerBaseActionController
        .startAction(name: '_RestaurantDetailsControllerBase.setFavorite');
    try {
      return super.setFavorite(value);
    } finally {
      _$_RestaurantDetailsControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void edit() {
    final _$actionInfo = _$_RestaurantDetailsControllerBaseActionController
        .startAction(name: '_RestaurantDetailsControllerBase.edit');
    try {
      return super.edit();
    } finally {
      _$_RestaurantDetailsControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void showFullImage() {
    final _$actionInfo = _$_RestaurantDetailsControllerBaseActionController
        .startAction(name: '_RestaurantDetailsControllerBase.showFullImage');
    try {
      return super.showFullImage();
    } finally {
      _$_RestaurantDetailsControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
restaurant: ${restaurant},
savedImage: ${savedImage}
    ''';
  }
}
