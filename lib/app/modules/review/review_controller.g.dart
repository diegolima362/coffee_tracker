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
  Computed<Future<List<ReviewModel>>> _$reviewsComputed;

  @override
  Future<List<ReviewModel>> get reviews => (_$reviewsComputed ??=
          Computed<Future<List<ReviewModel>>>(() => super.reviews,
              name: '_ReviewControllerBase.reviews'))
      .value;

  final _$_reviewsAtom = Atom(name: '_ReviewControllerBase._reviews');

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

  final _$_loadReviewsAsyncAction =
      AsyncAction('_ReviewControllerBase._loadReviews');

  @override
  Future<void> _loadReviews() {
    return _$_loadReviewsAsyncAction.run(() => super._loadReviews());
  }

  @override
  String toString() {
    return '''
reviews: ${reviews}
    ''';
  }
}
