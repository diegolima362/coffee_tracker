import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:flutter/foundation.dart';

class RestaurantModel {
  final int id;

  double rate;

  String name;
  String address;
  String city;
  String state;

  String openDays;

  String photoURL;

  List<ReviewModel> _reviews;

  RestaurantModel({
    @required this.id,
    @required this.name,
    @required this.address,
    @required this.city,
    @required this.state,
    this.rate,
    this.photoURL,
    this.openDays,
  }) {
    _reviews = List<ReviewModel>();
  }

  List<ReviewModel> get allReviews => _reviews;

  void addReview(ReviewModel review) => _reviews.add(review);

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      photoURL: json['photoURL'],
      openDays: json['openDays'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'city': city,
        'state': state,
        'photoURL': photoURL,
        'openDays': openDays,
        'rate': rate,
      };
}
