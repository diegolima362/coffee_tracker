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
  final _$restaurantsAtom = Atom(name: '_RestaurantControllerBase.restaurants');

  @override
  ObservableList<RestaurantModel> get restaurants {
    _$restaurantsAtom.reportRead();
    return super.restaurants;
  }

  @override
  set restaurants(ObservableList<RestaurantModel> value) {
    _$restaurantsAtom.reportWrite(value, super.restaurants, () {
      super.restaurants = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_RestaurantControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$loadDataAsyncAction =
      AsyncAction('_RestaurantControllerBase.loadData');

  @override
  Future<void> loadData() {
    return _$loadDataAsyncAction.run(() => super.loadData());
  }

  final _$addRestaurantAsyncAction =
      AsyncAction('_RestaurantControllerBase.addRestaurant');

  @override
  Future<void> addRestaurant() {
    return _$addRestaurantAsyncAction.run(() => super.addRestaurant());
  }

  final _$_RestaurantControllerBaseActionController =
      ActionController(name: '_RestaurantControllerBase');

  @override
  void sortBy(SortBy value) {
    final _$actionInfo = _$_RestaurantControllerBaseActionController
        .startAction(name: '_RestaurantControllerBase.sortBy');
    try {
      return super.sortBy(value);
    } finally {
      _$_RestaurantControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showDetails({@required RestaurantModel restaurant}) {
    final _$actionInfo = _$_RestaurantControllerBaseActionController
        .startAction(name: '_RestaurantControllerBase.showDetails');
    try {
      return super.showDetails(restaurant: restaurant);
    } finally {
      _$_RestaurantControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
restaurants: ${restaurants},
isLoading: ${isLoading}
    ''';
  }
}
