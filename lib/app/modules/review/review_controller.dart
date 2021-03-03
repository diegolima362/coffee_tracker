import 'package:coffee_tracker/app/modules/review/sort_by.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:coffee_tracker/app/utils/connection_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'review_controller.g.dart';

@Injectable()
class ReviewController = _ReviewControllerBase with _$ReviewController;

abstract class _ReviewControllerBase with Store {
  @observable
  bool isLoading;

  @observable
  String filter = '';

  @observable
  ObservableList<ReviewModel> reviews;

  _ReviewControllerBase() {
    loadData();
  }

  Future<bool> get hasRestaurants async {
    final IStorageRepository storage = Modular.get();
    final data = await storage.getAllRestaurants();
    return data.isNotEmpty;
  }

  @action
  Future<void> addReview() async {
    try {
      if (kIsWeb || await CheckConnection.checkConnection()) {
        if (!await hasRestaurants) {
          print('> empty data');
        } else {
          Modular.to.pushNamed('/reviews/edit', arguments: null);
        }
      }
    } on PlatformException {
      rethrow;
    } catch (error) {
      print(error);
    }
  }

  @action
  Future<void> loadData() async {
    reviews = ObservableList<ReviewModel>();

    isLoading = true;
    final IStorageRepository storage = Modular.get();
    reviews.addAll(await storage.getAllReviews());

    reviews.reversed
        .toList()
        .sort((a, b) => a.reviewDate.compareTo(b.reviewDate));

    isLoading = false;
  }

  @action
  void showDetails(ReviewModel review) {
    Modular.to.pushNamed('/reviews/details', arguments: review);
  }

  @action
  void setFilter(String value) => filter = value;

  @action
  void sortBy(SortBy value) {
    if (reviews == null || reviews.isEmpty) return;
    if (value == SortBy.RESTAURANT) {
      reviews.sort((a, b) => a.restaurantName
          .toLowerCase()
          .compareTo(b.restaurantName.toLowerCase()));
    } else if (value == SortBy.RATE) {
      reviews.sort((a, b) => b.rate.compareTo(a.rate));
    } else if (value == SortBy.DATE) {
      reviews.sort((a, b) => a.visitDate.compareTo(b.visitDate));
    }
  }
}
