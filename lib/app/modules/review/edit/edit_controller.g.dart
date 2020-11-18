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
  final _$isLoadingAtom = Atom(name: '_EditControllerBase.isLoading');

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

  final _$visitDateAtom = Atom(name: '_EditControllerBase.visitDate');

  @override
  DateTime get visitDate {
    _$visitDateAtom.reportRead();
    return super.visitDate;
  }

  @override
  set visitDate(DateTime value) {
    _$visitDateAtom.reportWrite(value, super.visitDate, () {
      super.visitDate = value;
    });
  }

  final _$visitTimeAtom = Atom(name: '_EditControllerBase.visitTime');

  @override
  TimeOfDay get visitTime {
    _$visitTimeAtom.reportRead();
    return super.visitTime;
  }

  @override
  set visitTime(TimeOfDay value) {
    _$visitTimeAtom.reportWrite(value, super.visitTime, () {
      super.visitTime = value;
    });
  }

  final _$textAtom = Atom(name: '_EditControllerBase.text');

  @override
  String get text {
    _$textAtom.reportRead();
    return super.text;
  }

  @override
  set text(String value) {
    _$textAtom.reportWrite(value, super.text, () {
      super.text = value;
    });
  }

  final _$reviewAtom = Atom(name: '_EditControllerBase.review');

  @override
  ReviewModel get review {
    _$reviewAtom.reportRead();
    return super.review;
  }

  @override
  set review(ReviewModel value) {
    _$reviewAtom.reportWrite(value, super.review, () {
      super.review = value;
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

  final _$rateAtom = Atom(name: '_EditControllerBase.rate');

  @override
  double get rate {
    _$rateAtom.reportRead();
    return super.rate;
  }

  @override
  set rate(double value) {
    _$rateAtom.reportWrite(value, super.rate, () {
      super.rate = value;
    });
  }

  final _$restaurantsAtom = Atom(name: '_EditControllerBase.restaurants');

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

  final _$_loadDataAsyncAction = AsyncAction('_EditControllerBase._loadData');

  @override
  Future<void> _loadData() {
    return _$_loadDataAsyncAction.run(() => super._loadData());
  }

  final _$saveAsyncAction = AsyncAction('_EditControllerBase.save');

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  final _$_EditControllerBaseActionController =
      ActionController(name: '_EditControllerBase');

  @override
  void setRate(double value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setRate');
    try {
      return super.setRate(value);
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
  void setText(String value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setText');
    try {
      return super.setText(value);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVisitTime(TimeOfDay value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setVisitTime');
    try {
      return super.setVisitTime(value);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVisitDate(DateTime value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setVisitDate');
    try {
      return super.setVisitDate(value);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReview(ReviewModel value) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.setReview');
    try {
      return super.setReview(value);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ReviewModel _reviewFromState() {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase._reviewFromState');
    try {
      return super._reviewFromState();
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
visitDate: ${visitDate},
visitTime: ${visitTime},
text: ${text},
review: ${review},
restaurant: ${restaurant},
rate: ${rate},
restaurants: ${restaurants}
    ''';
  }
}
