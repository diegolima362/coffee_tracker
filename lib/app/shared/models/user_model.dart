import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String photoURL;
  final String displayName;
  bool emailVerified;

  UserModel({
    @required this.id,
    this.photoURL,
    this.displayName,
    this.emailVerified,
  });

  String toString() {
    return '{ id : $id, displayName: $displayName, emailVerified: $emailVerified }';
  }
}
