import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class TrainingEvent extends Equatable {
  const TrainingEvent();

  @override
  List<Object> get props => [];
}

class TrainingStarted extends TrainingEvent {
  final int duration = 0;
  final double distance = 0.0;

  const TrainingStarted();

  @override
  List<Object> get props => [duration, distance];

  @override
  String toString() => "TrainingStarted { duration: $duration distance: $distance }";
}

class TrainingPaused extends TrainingEvent {}

class TrainingResumed extends TrainingEvent {}

class TrainingReset extends TrainingEvent {}

class TrainingFinished extends TrainingEvent {}

class TrainingTicked extends TrainingEvent {
  final int duration;
  final double distance;
  final Position position;

  const TrainingTicked({@required this.duration, @required this.distance, @required this.position});

  @override
  List<Object> get props => [duration, distance, position];

  @override
  String toString() => "TrainingTicked { duration: $duration distance $distance last position $position}";
}
