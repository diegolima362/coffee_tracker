class MediaInfo {
  final String id;
  final int source;
  final String restaurantId;
  final String type;
  final int size;
  DateTime accessed;
  bool synced = false;

  MediaInfo({
    this.id,
    this.source,
    this.restaurantId,
    this.type,
    this.size,
    this.accessed,
    this.synced,
  });

  factory MediaInfo.fromMap(Map<String, dynamic> map) {
    return MediaInfo(
      id: map['id'],
      source: map['source'],
      restaurantId: map['restaurantId'],
      type: map['type'],
      size: map['size'],
      accessed: DateTime.fromMicrosecondsSinceEpoch(
          (map['accessed'] * 100000).toInt()),
      synced: map['synced'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'source': source,
        'restaurantId': restaurantId,
        'type': type,
        'size': size,
        'accessed': (accessed.microsecondsSinceEpoch / 100000.0),
        'synced': synced,
      };
}
