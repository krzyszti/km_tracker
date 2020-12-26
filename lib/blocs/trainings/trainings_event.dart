import 'package:equatable/equatable.dart';
import 'package:km_tracker/models/models.dart';

abstract class TrainingsEvent extends Equatable {
  const TrainingsEvent();

  @override
  List<Object> get props => [];
}

class TrainingsLoaded extends TrainingsEvent {}

class TrainingAdded extends TrainingsEvent {
  final Training training;

  const TrainingAdded(this.training);

  @override
  List<Object> get props => [training];

  @override
  String toString() => 'TrainingAdded { training: $training }';
}
