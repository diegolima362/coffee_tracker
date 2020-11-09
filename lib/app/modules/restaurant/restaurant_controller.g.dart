// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $RestaurantController = BindInject(
  (i) => RestaurantController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RestaurantController on _RestaurantControllerBase, Store {
  Computed<Future<List<RestaurantModel>>> _$allRestaurantsComputed;

  @override
  Future<List<RestaurantModel>> get allRestaurants =>
      (_$allRestaurantsComputed ??= Computed<Future<List<RestaurantModel>>>(
              () => super.allRestaurants,
              name: '_RestaurantControllerBase.allRestaurants'))
          .value;

  final _$restaurantsAtom = Atom(name: '_RestaurantControllerBase.restaurants');

  @override
  List<RestaurantModel> get restaurants {
    _$restaurantsAtom.reportRead();
    return super.restaurants;
  }

  @override
  set restaurants(List<RestaurantModel> value) {
    _$restaurantsAtom.reportWrite(value, super.restaurants, () {
      super.restaurants = value;
    });
  }

  final _$_loadRestaurantsAsyncAction =
      AsyncAction('_RestaurantControllerBase._loadRestaurants');

  @override
  Future<void> _loadRestaurants() {
    return _$_loadRestaurantsAsyncAction.run(() => super._loadRestaurants());
  }

  @override
  String toString() {
    return '''
restaurants: ${restaurants},
allRestaurants: ${allRestaurants}
    ''';
  }
}
