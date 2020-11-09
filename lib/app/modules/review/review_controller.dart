import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:coffee_tracker/app/shared/repositories/local_storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'review_controller.g.dart';

@Injectable()
class ReviewController = _ReviewControllerBase with _$ReviewController;

abstract class _ReviewControllerBase with Store {
  _ReviewControllerBase() {
    _loadReviews();
  }

  @observable
  List<ReviewModel> _reviews;

  @action
  Future<void> _loadReviews() async {
    final ILocalStorage storage = Modular.get();
    _reviews = await storage.getAllReviews();
  }

  @computed
  Future<List<ReviewModel>> get reviews async {
    if (_reviews == null) {
      final ILocalStorage storage = Modular.get();
      _reviews = await storage.getAllReviews();
    }

    _reviews.sort((a, b) => a.reviewDate.compareTo(b.reviewDate));

    return _reviews;
  }

  @computed
  Future<List<ReviewModel>> get last async {
    if (_reviews == null) {
      final ILocalStorage storage = Modular.get();
      _reviews = await storage.getAllReviews();
    }

    _reviews.sort((a, b) => a.reviewDate.compareTo(b.reviewDate));

    return _reviews.reversed.toList().sublist(0, 5);
  }
}
