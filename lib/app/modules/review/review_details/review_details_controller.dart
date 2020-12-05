import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Map<String, String> get shareData {
    final name = FirebaseAuth.instance.currentUser.displayName;

    return {
      'text': review.getRecommendationText(name),
      'subject': 'Avaliação de Café: ${review.restaurantName}',
    };
  }

  @action
  void edit() {
    Modular.link.pushNamed('/edit', arguments: review);
  }

  @action
  Future<void> delete() async {
    final IStorageRepository storage = Modular.get();
    await storage.deleteReview(review.id);

    final ReviewController controller = Modular.get();
    await controller.loadData();

    Modular.navigator.pop();
  }
}
