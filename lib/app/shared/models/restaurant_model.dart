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

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      fileName: map['fileName'] ?? '',
      favorite: map['favorite'] ?? false,
      commentary: map['commentary'] ?? '',
      registerDate: DateTime.fromMillisecondsSinceEpoch(
          map['registerDate'] ?? DateTime.now().millisecondsSinceEpoch),
    );
  }

  Map<String, dynamic> toMap() => {
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
