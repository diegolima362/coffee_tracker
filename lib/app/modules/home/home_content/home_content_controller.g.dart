// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_content_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeContentController = BindInject(
  (i) => HomeContentController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeContentController on _HomeContentBase, Store {
  final _$restaurantsAtom = Atom(name: '_HomeContentBase.restaurants');

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

  final _$loadingRestaurantsAtom =
      Atom(name: '_HomeContentBase.loadingRestaurants');

  @override
  bool get loadingRestaurants {
    _$loadingRestaurantsAtom.reportRead();
    return super.loadingRestaurants;
  }

  @override
  set loadingRestaurants(bool value) {
    _$loadingRestaurantsAtom.reportWrite(value, super.loadingRestaurants, () {
      super.loadingRestaurants = value;
    });
  }

  final _$loadingReviewsAtom = Atom(name: '_HomeContentBase.loadingReviews');

  @override
  bool get loadingReviews {
    _$loadingReviewsAtom.reportRead();
    return super.loadingReviews;
  }

  @override
  set loadingReviews(bool value) {
    _$loadingReviewsAtom.reportWrite(value, super.loadingReviews, () {
      super.loadingReviews = value;
    });
  }

  final _$reviewsAtom = Atom(name: '_HomeContentBase.reviews');

  @override
  ObservableList<ReviewModel> get reviews {
    _$reviewsAtom.reportRead();
    return super.reviews;
  }

  @override
  set reviews(ObservableList<ReviewModel> value) {
    _$reviewsAtom.reportWrite(value, super.reviews, () {
      super.reviews = value;
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
  void showRestaurantDetails(RestaurantModel restaurant) {
    final _$actionInfo = _$_HomeContentBaseActionController.startAction(
        name: '_HomeContentBase.showRestaurantDetails');
    try {
      return super.showRestaurantDetails(restaurant);
    } finally {
      _$_HomeContentBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showReviewsDetails(ReviewModel review) {
    final _$actionInfo = _$_HomeContentBaseActionController.startAction(
        name: '_HomeContentBase.showReviewsDetails');
    try {
      return super.showReviewsDetails(review);
    } finally {
      _$_HomeContentBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
restaurants: ${restaurants},
loadingRestaurants: ${loadingRestaurants},
loadingReviews: ${loadingReviews},
reviews: ${reviews}
    ''';
  }
}
