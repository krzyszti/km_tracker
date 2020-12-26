import 'package:equatable/equatable.dart';
import 'package:km_tracker/repository/training_entity.dart';

class Training extends Equatable {
  final int id;
  final DateTime date;
  final double distance;

  Training({
    int id,
    DateTime date,
    this.distance = 0,
  })  : this.date = date ?? DateTime.now(),
        this.id = id;

  Training copyWith({int id, DateTime date, double distance}) {
    return Training(
        id: id ?? this.id,
        date: date ?? this.date,
        distance: id ?? this.distance);
  }

  @override
  List<Object> get props => [id, date, distance];

  @override
  String toString() {
    return '$distance km $date';
  }

  TrainingEntity toEntity() {
    return TrainingEntity(id, date, distance);
  }

  static Training fromEntity(TrainingEntity entity) {
    return Training(
      id: entity.id,
      date: entity.date ?? DateTime.now(),
      distance: entity.distance ?? 0,
    );
  }

  String totalDistance() {
    final String kmDistance = (distance / 1000).toStringAsFixed(2);
    return '$kmDistance km';
  }

  String dateTime() {
    return '${date.hour}:${date.minute.toString().padLeft(2,'0')} ${date.day} ${date.month} ${date.year}';
  }
}
