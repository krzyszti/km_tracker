class TrainingEntity {
  final int id;
  final DateTime date;
  final double distance;

  TrainingEntity(this.id, this.date, this.distance);

  Map<String, Object> toJson() {
    return {
      'date': date.toString(),
      'distance': distance.toString(),
    };
  }

  @override
  String toString() {
    return '$distance km $date';
  }

  static TrainingEntity fromJson(Map<String, Object> json) {
    return TrainingEntity(
      int.parse(json['id']),
      DateTime.parse(json['date']),
      double.parse(json['distance'])
    );
  }
}
