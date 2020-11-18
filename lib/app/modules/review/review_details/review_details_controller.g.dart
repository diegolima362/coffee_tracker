// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_details_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ReviewDetailsController = BindInject(
  (i) => ReviewDetailsController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReviewDetailsController on _ReviewDetailsControllerBase, Store {
  final _$reviewAtom = Atom(name: '_ReviewDetailsControllerBase.review');

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

  final _$deleteAsyncAction =
      AsyncAction('_ReviewDetailsControllerBase.delete');

  @override
  Future<void> delete() {
    return _$deleteAsyncAction.run(() => super.delete());
  }

  final _$_ReviewDetailsControllerBaseActionController =
      ActionController(name: '_ReviewDetailsControllerBase');

  @override
  void setReview(ReviewModel r) {
    final _$actionInfo = _$_ReviewDetailsControllerBaseActionController
        .startAction(name: '_ReviewDetailsControllerBase.setReview');
    try {
      return super.setReview(r);
    } finally {
      _$_ReviewDetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void edit() {
    final _$actionInfo = _$_ReviewDetailsControllerBaseActionController
        .startAction(name: '_ReviewDetailsControllerBase.edit');
    try {
      return super.edit();
    } finally {
      _$_ReviewDetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
review: ${review}
    ''';
  }
}
