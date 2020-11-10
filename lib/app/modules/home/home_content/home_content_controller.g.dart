// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_content_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeContentController on _HomeContentBase, Store {
  Computed<Future<List<ReviewModel>>> _$lastComputed;

  @override
  Future<List<ReviewModel>> get last =>
      (_$lastComputed ??= Computed<Future<List<ReviewModel>>>(() => super.last,
              name: '_HomeContentBase.last'))
          .value;
  Computed<Future<List<RestaurantModel>>> _$favoritesComputed;

  @override
  Future<List<RestaurantModel>> get favorites => (_$favoritesComputed ??=
          Computed<Future<List<RestaurantModel>>>(() => super.favorites,
              name: '_HomeContentBase.favorites'))
      .value;

  final _$valueAtom = Atom(name: '_HomeContentBase.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$_restaurantsAtom = Atom(name: '_HomeContentBase._restaurants');

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

  final _$_reviewsAtom = Atom(name: '_HomeContentBase._reviews');

  @override
  List<ReviewModel> get _reviews {
    _$_reviewsAtom.reportRead();
    return super._reviews;
  }

  @override
  set _reviews(List<ReviewModel> value) {
    _$_reviewsAtom.reportWrite(value, super._reviews, () {
      super._reviews = value;
    });
  }

  final _$_loadRestaurantsAsyncAction =
      AsyncAction('_HomeContentBase._loadRestaurants');

  @override
  Future<void> _loadRestaurants() {
    return _$_loadRestaurantsAsyncAction.run(() => super._loadRestaurants());
  }

  final _$_loadReviewsAsyncAction =
      AsyncAction('_HomeContentBase._loadReviews');

  @override
  Future<void> _loadReviews() {
    return _$_loadReviewsAsyncAction.run(() => super._loadReviews());
  }

  final _$_HomeContentBaseActionController =
      ActionController(name: '_HomeContentBase');

  @override
  void increment() {
    final _$actionInfo = _$_HomeContentBaseActionController.startAction(
        name: '_HomeContentBase.increment');
    try {
      return super.increment();
    } finally {
      _$_HomeContentBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showDetails(RestaurantModel restaurant) {
    final _$actionInfo = _$_HomeContentBaseActionController.startAction(
        name: '_HomeContentBase.showDetails');
    try {
      return super.showDetails(restaurant);
    } finally {
      _$_HomeContentBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value},
last: ${last},
favorites: ${favorites}
    ''';
  }
}
