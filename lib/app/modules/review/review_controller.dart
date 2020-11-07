import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'review_controller.g.dart';

@Injectable()
class ReviewController = _ReviewControllerBase with _$ReviewController;

abstract class _ReviewControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
