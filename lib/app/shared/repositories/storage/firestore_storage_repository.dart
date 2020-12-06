import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/storage_repository_interface.dart';

part 'firestore_storage_repository.g.dart';

@Injectable()
class FireStoreStorageRepository implements IStorageRepository {
  List<RestaurantModel> _restaurants;
  List<ReviewModel> _reviews;

  @override
  Future<void> deleteRestaurant(String id) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final ref = FirebaseFirestore.instance.doc('users/$uid/restaurants/$id');
    return ref.delete().then((value) {
      print('> restaurant deleted');
      deleteReviews(id);
    }).catchError((error) => print('> failed to delete restaurant: $error'));
  }

  Future<void> deleteReviews(String restaurantId) async {
    _reviews.forEach((r) async {
      if (r.restaurantId == restaurantId) await deleteReview(r.id);
    });
  }

  @override
  Future<void> deleteReview(String id) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final ref = FirebaseFirestore.instance.doc('users/$uid/reviews/$id');
    return ref
        .delete()
        .then((value) => print('> review deleted'))
        .catchError((error) => print('> failed to delete review: $error'));
  }

  @override
  Future<List<RestaurantModel>> getAllRestaurants() async {
    if (_restaurants == null) _restaurants = List<RestaurantModel>();

    final uid = FirebaseAuth.instance.currentUser.uid;
    final data = await FirebaseFirestore.instance
        .collection('users/$uid/restaurants')
        .get();

    _restaurants = data.docs.map((d) {
      final model = RestaurantModel.fromMap(d.data());

      if (_reviews != null && _reviews.isNotEmpty) {
        _reviews.forEach((r) {
          if (r.restaurantId == model.id) model.addReview(r);
        });
      }

      return model;
    }).toList();

    return _restaurants;
  }

  @override
  Future<List<ReviewModel>> getAllReviews() async {
    if (_reviews == null) _reviews = List<ReviewModel>();

    final uid = FirebaseAuth.instance.currentUser.uid;
    final data =
        await FirebaseFirestore.instance.collection('users/$uid/reviews').get();

    _reviews = data.docs.map((d) => ReviewModel.fromMap(d.data())).toList();

    return _reviews;
  }

  @override
  Future<void> updateRestaurant(RestaurantModel restaurant) async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final ref = FirebaseFirestore.instance
        .doc('users/$uid/restaurants/${restaurant.id}');

    final map = (await ref.get()).data();
    RestaurantModel temp = RestaurantModel.fromMap(map);

    if (temp.name != restaurant.name) {
      _reviews.forEach((r) {
        if (r.restaurantId == restaurant.id) {
          r.restaurantName = restaurant.name;
          updateReview(r);
        }
      });
    }

    ref.update({
      if (temp.address != restaurant.address) 'address': restaurant.address,
      if (temp.city != restaurant.city) 'city': restaurant.city,
      if (temp.commentary != restaurant.commentary)
        'commentary': restaurant.commentary,
      if (temp.favorite != restaurant.favorite) 'favorite': restaurant.favorite,
      if (temp.fileName != restaurant.fileName) 'fileName': restaurant.fileName,
      if (temp.name != restaurant.name) 'name': restaurant.name,
      if (temp.state != restaurant.state) 'state': restaurant.state,
    }).then((value) {
      print('> restaurant updated');
      print(restaurant);
    }).catchError((error) => print('> failed to update restaurant: $error'));
  }

  @override
  Future<void> updateReview(ReviewModel review) async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final ref =
        FirebaseFirestore.instance.doc('users/$uid/reviews/${review.id}');

    final map = (await ref.get()).data();
    ReviewModel temp = ReviewModel.fromMap(map);

    print(temp);

    ref.update({
      if (temp.rate != review.rate) 'rate': review.rate,
      if (temp.restaurantName != review.restaurantName)
        'restaurantName': review.restaurantName,
      if (temp.visitDate != review.visitDate) 'visitDate': review.visitDate,
      if (temp.text != review.text) 'text': review.text
    }).then((value) {
      print('> review updated');
      print(review);
    }).catchError((error) => print('> failed to update review: $error'));
  }

  @override
  Future<void> persistRestaurant(RestaurantModel restaurant) async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final ref = FirebaseFirestore.instance
        .doc('users/$uid/restaurants/${restaurant.id}');

    return ref.set(restaurant.toMap()).then((value) {
      print('> restaurant synced');
      print(restaurant);
    }).catchError((error) => print('> failed to add restaurant: $error'));
  }

  @override
  Future<void> persistReview(ReviewModel review) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final ref =
        FirebaseFirestore.instance.doc('users/$uid/reviews/${review.id}');
    return ref.set(review.toMap()).then((value) {
      print('> review synced');
      print(review);
    }).catchError((error) => print('> failed to add review: $error'));
  }

  @override
  void dispose() {}
}
