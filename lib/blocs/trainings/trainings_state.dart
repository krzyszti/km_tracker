import 'package:equatable/equatable.dart';
import 'package:km_tracker/models/models.dart';

abstract class TrainingsState extends Equatable {
  const TrainingsState();

  @override
  List<Object> get props => [];
}

class TrainingsLoadInProgress extends TrainingsState {}

class TrainingsLoadSuccess extends TrainingsState {
  final List<Training> trainings;

  const TrainingsLoadSuccess([this.trainings = const []]);

  @override
  List<Object> get props => [trainings];

  @override
  String toString() => 'TrainingsLoadSuccess { trainings: $trainings }';
}

class TrainingsLoadFailure extends TrainingsState {}

class TrainingCreateFailure extends TrainingsState {}
