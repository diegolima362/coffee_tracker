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
  List<ReviewModel> reviews;

  @action
  Future<void> _loadReviews() async {
    final ILocalStorage storage = Modular.get();
    reviews = await storage.getAllReviews();
  }

  @computed
  Future<List<ReviewModel>> get allReviews async {
    if (reviews == null) {
      final ILocalStorage storage = Modular.get();
      reviews = await storage.getAllReviews();
    }

    reviews.sort((a, b) => a.reviewDate.compareTo(b.reviewDate));

    return reviews;
  }
}
