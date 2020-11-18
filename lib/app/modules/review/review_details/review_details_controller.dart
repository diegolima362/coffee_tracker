import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:coffee_tracker/app/shared/repositories/local_storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../review_controller.dart';

part 'review_details_controller.g.dart';

@Injectable()
class ReviewDetailsController = _ReviewDetailsControllerBase
    with _$ReviewDetailsController;

abstract class _ReviewDetailsControllerBase with Store {
  _ReviewDetailsControllerBase() {
    final ReviewModel r = Modular.args.data;
    setReview(r);
  }

  @observable
  ReviewModel review;

  @action
  void setReview(ReviewModel r) => review = r;

  @action
  void edit() {
    Modular.link.pushNamed('/edit', arguments: review);
  }

  @action
  Future<void> delete() async {
    final ILocalStorage storage = Modular.get();
    await storage.deleteReview(review.id);

    final ReviewController controller = Modular.get();
    await controller.loadReviews();

    Modular.navigator.pop();
  }
}
