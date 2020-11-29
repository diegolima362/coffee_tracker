import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  AuthController auth = Modular.get();

  @observable
  int currentIndex = 0;

  @action
  void updateCurrentIndex(int index) => this.currentIndex = index;
}
