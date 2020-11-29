// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ReviewController = BindInject(
  (i) => ReviewController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReviewController on _ReviewControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_ReviewControllerBase.isLoading');

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

  final _$reviewsAtom = Atom(name: '_ReviewControllerBase.reviews');

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

  final _$loadDataAsyncAction = AsyncAction('_ReviewControllerBase.loadData');

  @override
  Future<void> loadData() {
    return _$loadDataAsyncAction.run(() => super.loadData());
  }

  final _$addReviewAsyncAction = AsyncAction('_ReviewControllerBase.addReview');

  @override
  Future<void> addReview() {
    return _$addReviewAsyncAction.run(() => super.addReview());
  }

  final _$_ReviewControllerBaseActionController =
      ActionController(name: '_ReviewControllerBase');

  @override
  void showDetails({@required ReviewModel review}) {
    final _$actionInfo = _$_ReviewControllerBaseActionController.startAction(
        name: '_ReviewControllerBase.showDetails');
    try {
      return super.showDetails(review: review);
    } finally {
      _$_ReviewControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sortBy(SortBy value) {
    final _$actionInfo = _$_ReviewControllerBaseActionController.startAction(
        name: '_ReviewControllerBase.sortBy');
    try {
      return super.sortBy(value);
    } finally {
      _$_ReviewControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
reviews: ${reviews}
    ''';
  }
}
