import 'package:coffee_tracker/app/modules/review/review_controller.dart';
import 'package:coffee_tracker/app/modules/review/review_details/review_details_controller.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:coffee_tracker/app/utils/id_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'edit_controller.g.dart';

@Injectable()
class EditController = _EditControllerBase with _$EditController;

abstract class _EditControllerBase with Store {
  @observable
  bool isLoading;

  @observable
  DateTime visitDate;

  @observable
  TimeOfDay visitTime;

  @observable
  String text;

  @observable
  ReviewModel review;

  @observable
  RestaurantModel restaurant;

  @observable
  double rate;

  @observable
  ObservableList<RestaurantModel> restaurants;

  _EditControllerBase() {
    final ReviewModel review = Modular.args.data;
    setReview(review);

    final date = DateTime.now();

    setRate(review?.rate ?? 2.5);
    setVisitDate(review?.visitDate ?? date);
    setVisitTime(TimeOfDay.fromDateTime(review?.visitDate ?? date));
    setText(review?.text ?? '');

    _loadData();
  }

  @action
  Future<void> _loadData() async {
    isLoading = true;
    restaurants = ObservableList<RestaurantModel>();

    final IStorageRepository storage = Modular.get();
    final data = await storage.getAllRestaurants();

    if (data.isEmpty) {
      print('> empty data');
      isLoading = false;
      _goToAddRestaurant();
    } else
      print(data);

    restaurants.addAll(data);

    if (review?.restaurantId != null) {
      final l = restaurants.where((r) => r.id == review.restaurantId).toList();
      if (l.length > 0) {
        setRestaurant(l[0]);
      } else {
        setRestaurant(restaurants[0]);
      }
    } else {
      setRestaurant(restaurants[0]);
    }

    isLoading = false;
  }

  @action
  void setRate(double value) => rate = value;

  @action
  void setRestaurant(RestaurantModel value) => restaurant = value;

  @action
  void setText(String value) => text = value;

  @action
  void setVisitTime(TimeOfDay value) => visitTime = value;

  @action
  void setVisitDate(DateTime value) => visitDate = value;

  @action
  void setReview(ReviewModel value) => review = value;

  @action
  ReviewModel _reviewFromState() {
    final reviewDate = DateTime.now();
    final id = review?.id ?? IdGenerator.documentIdFromCurrentDate();

    final date = DateTime(
      visitDate.year,
      visitDate.month,
      visitDate.day,
      visitTime.hour,
      visitTime.minute,
    );

    return ReviewModel(
      id: id,
      restaurantId: restaurant.id,
      restaurantName: restaurant.name,
      rate: rate,
      reviewDate: reviewDate,
      visitDate: date,
      text: text,
    );
  }

  @action
  Future<void> save() async {
    final IStorageRepository storage = Modular.get();
    final r = _reviewFromState();

    if (review != null) {
      storage.updateReview(r);
      final ReviewDetailsController controller = Modular.get();
      controller.setReview(r);
    } else {
      await storage.persistReview(r);

      final ReviewController controller = Modular.get();
      await controller.loadData();
    }
    Modular.navigator.pop();
  }

  void _goToAddRestaurant() {
    Modular.to.pop();
  }
}
