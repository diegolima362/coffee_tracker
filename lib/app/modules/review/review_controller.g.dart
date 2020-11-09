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
  Computed<Future<List<ReviewModel>>> _$allReviewsComputed;

  @override
  Future<List<ReviewModel>> get allReviews => (_$allReviewsComputed ??=
          Computed<Future<List<ReviewModel>>>(() => super.allReviews,
              name: '_ReviewControllerBase.allReviews'))
      .value;

  final _$reviewsAtom = Atom(name: '_ReviewControllerBase.reviews');

  @override
  List<ReviewModel> get reviews {
    _$reviewsAtom.reportRead();
    return super.reviews;
  }

  @override
  set reviews(List<ReviewModel> value) {
    _$reviewsAtom.reportWrite(value, super.reviews, () {
      super.reviews = value;
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
reviews: ${reviews},
allReviews: ${allReviews}
    ''';
  }
}
