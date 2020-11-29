class IdGenerator {
  static String documentIdFromCurrentDate() =>
      (DateTime.now().millisecondsSinceEpoch / 6000).floor().toString();
}
