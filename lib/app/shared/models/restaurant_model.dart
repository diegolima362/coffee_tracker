import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/foundation.dart';

class RestaurantModel {
  final String id;
  String name;
  String commentary;
  String address;
  String city;
  String state;
  bool favorite;
  String fileName;
  final DateTime registerDate;

  List<ReviewModel> _reviews;

  RestaurantModel({
    @required this.id,
    @required this.registerDate,
    @required this.name,
    @required this.city,
    @required this.state,
    this.address = '',
    this.favorite = false,
    this.fileName = '',
    this.commentary = '',
  }) {
    _reviews = List<ReviewModel>();
  }

  List<ReviewModel> get allReviews => _reviews;

  double get rate {
    if (_reviews.isEmpty) {
      return 0;
    } else {
      return _reviews.fold(0, (v, r) => v += r.rate) / _reviews.length;
    }
  }

  int get totalVisits => _reviews.length;

  String getRecommendationText(String userName) {
    final text = StringBuffer(
        '$userName acha que você vai gostar de ir ao ${Format.capitalString(name)}');

    if (address.isNotEmpty) text.write('\nEm ${Format.capitalString(address)}');
    text.write('\n${Format.capitalString(city)}, ${state.toUpperCase()}');

    if (allReviews.isNotEmpty) text.write('\n⭐ $rate');

    if (commentary.isNotEmpty) text.write('\n"$commentary"');

    return text.toString();
  }

  void addReview(ReviewModel review) => _reviews.add(review);

  void addReviews(List<ReviewModel> reviews) => _reviews.addAll(reviews);

  factory RestaurantModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) return null;

    return RestaurantModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      fileName: data['fileName'] ?? '',
      favorite: data['favorite'] ?? false,
      commentary: data['commentary'] ?? '',
      registerDate: DateTime.fromMillisecondsSinceEpoch(
          data['registerDate'] ?? DateTime.now().millisecondsSinceEpoch),
    );
  }

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      fileName: json['fileName'] ?? '',
      favorite: json['favorite'] ?? false,
      commentary: json['commentary'] ?? '',
      registerDate: DateTime.fromMillisecondsSinceEpoch(
          json['registerDate'] ?? DateTime.now().millisecondsSinceEpoch),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address ?? '',
        'city': city ?? '',
        'state': state ?? '',
        'fileName': fileName ?? '',
        'favorite': favorite ?? false,
        'commentary': commentary ?? '',
        'registerDate': registerDate?.millisecondsSinceEpoch ??
            DateTime.now().millisecondsSinceEpoch,
      };

  @override
  String toString() {
    return '$name, $city, $state';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          commentary == other.commentary &&
          address == other.address &&
          city == other.city &&
          state == other.state &&
          favorite == other.favorite &&
          fileName == other.fileName &&
          registerDate == other.registerDate &&
          _reviews == other._reviews;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      commentary.hashCode ^
      address.hashCode ^
      city.hashCode ^
      state.hashCode ^
      favorite.hashCode ^
      fileName.hashCode ^
      registerDate.hashCode ^
      _reviews.hashCode;
}
