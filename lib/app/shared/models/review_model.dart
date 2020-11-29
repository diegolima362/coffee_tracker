import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/foundation.dart';

class ReviewModel {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final DateTime reviewDate;
  DateTime visitDate;
  String text;
  double rate;

  ReviewModel({
    @required this.id,
    @required this.restaurantName,
    @required this.restaurantId,
    @required this.reviewDate,
    @required this.visitDate,
    @required this.rate,
    @required this.text,
  });

  String getShareText(String userName) {
    final review = StringBuffer(
        '$userName compartilhou uma experiencia sobre ${Format.capitalString(restaurantName)}');

    review.write('\n⭐ $rate');

    if (text.isNotEmpty) review.write('\n"$text"');

    return review.toString();
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    final _reviewDate = DateTime.fromMillisecondsSinceEpoch(json['reviewDate']);
    final _visitDate = DateTime.fromMillisecondsSinceEpoch(json['visitDate']);

    return ReviewModel(
      id: json['id'],
      restaurantId: json['restaurantId'],
      restaurantName: json['restaurantName'],
      reviewDate: _reviewDate,
      visitDate: _visitDate,
      rate: json['rate'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'restaurantName': restaurantName,
        'restaurantId': restaurantId,
        'reviewDate': reviewDate.millisecondsSinceEpoch,
        'visitDate': visitDate.millisecondsSinceEpoch,
        'rate': rate,
        'text': text,
      };

  @override
  String toString() {
    return "{'id': $id,"
        "'restaurantName': $restaurantName,"
        "'restaurantId': $restaurantId,"
        "'reviewDate': $reviewDate"
        "'visitDate': $visitDate,"
        "'rate': $rate,"
        "'text': $text}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          restaurantId == other.restaurantId &&
          restaurantName == other.restaurantName &&
          reviewDate == other.reviewDate &&
          visitDate == other.visitDate &&
          text == other.text &&
          rate == other.rate;

  @override
  int get hashCode =>
      id.hashCode ^
      restaurantId.hashCode ^
      restaurantName.hashCode ^
      reviewDate.hashCode ^
      visitDate.hashCode ^
      text.hashCode ^
      rate.hashCode;
}
