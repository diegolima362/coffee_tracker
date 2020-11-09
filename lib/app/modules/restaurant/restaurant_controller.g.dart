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
  Computed<Future<List<RestaurantModel>>> _$restaurantsComputed;

  @override
  Future<List<RestaurantModel>> get restaurants => (_$restaurantsComputed ??=
          Computed<Future<List<RestaurantModel>>>(() => super.restaurants,
              name: '_RestaurantControllerBase.restaurants'))
      .value;

  final _$_restaurantsAtom =
      Atom(name: '_RestaurantControllerBase._restaurants');

  @override
  List<RestaurantModel> get _restaurants {
    _$_restaurantsAtom.reportRead();
    return super._restaurants;
  }

  @override
  set _restaurants(List<RestaurantModel> value) {
    _$_restaurantsAtom.reportWrite(value, super._restaurants, () {
      super._restaurants = value;
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
restaurants: ${restaurants}
    ''';
  }
}
