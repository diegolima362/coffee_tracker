import 'package:flutter/foundation.dart';

class ReviewModel {
  final int restaurantId;
  final String restaurantName;
  final String reviewDate;
  final String visitDate;
  String text;
  double rate;

  ReviewModel({
    @required this.restaurantName,
    @required this.restaurantId,
    @required this.reviewDate,
    @required this.visitDate,
    @required this.rate,
    @required this.text,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      restaurantId: json['restaurantId'],
      restaurantName: json['restaurantName'],
      reviewDate: json['reviewDate'],
      visitDate: json['visitDate'],
      rate: json['rate'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() => {
        'restaurantName': restaurantName,
        'restaurantId': restaurantId,
        'reviewDate': reviewDate,
        'visitDate': visitDate,
        'rate': rate,
        'text': text,
      };
}
