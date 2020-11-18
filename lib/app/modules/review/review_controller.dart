import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:coffee_tracker/app/shared/repositories/local_storage/local_storage_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'review_controller.g.dart';

@Injectable()
class ReviewController = _ReviewControllerBase with _$ReviewController;

abstract class _ReviewControllerBase with Store {
  _ReviewControllerBase() {
    loadReviews();
  }

  @observable
  bool isLoading;

  @observable
  ObservableList<ReviewModel> reviews;

  @action
  Future<void> loadReviews() async {
    reviews = ObservableList<ReviewModel>();

    isLoading = true;
    final ILocalStorage storage = Modular.get();
    reviews.addAll(await storage.getAllReviews());

    reviews.reversed
        .toList()
        .sort((a, b) => a.reviewDate.compareTo(b.reviewDate));

    isLoading = false;
  }

  @action
  void showDetails({@required ReviewModel review}) {
    Modular.to.pushNamed('review/details', arguments: review);
  }

  @action
  void addReview() {
    Modular.to.pushNamed('review/edit', arguments: null);
  }
}
