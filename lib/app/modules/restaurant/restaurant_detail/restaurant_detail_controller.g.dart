// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_detail_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $RestaurantDetailController = BindInject(
  (i) => RestaurantDetailController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RestaurantDetailController on _RestaurantDetailControllerBase, Store {
  final _$restaurantAtom =
      Atom(name: '_RestaurantDetailControllerBase.restaurant');

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

  @override
  String toString() {
    return '''
restaurant: ${restaurant}
    ''';
  }
}
