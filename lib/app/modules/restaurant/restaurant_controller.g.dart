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
  final _$valueAtom = Atom(name: '_RestaurantControllerBase.value');

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

  final _$_RestaurantControllerBaseActionController =
      ActionController(name: '_RestaurantControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$_RestaurantControllerBaseActionController
        .startAction(name: '_RestaurantControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_RestaurantControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
