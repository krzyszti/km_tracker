import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class TrainingState extends Equatable {
  final int duration;
  final double distance;
  final Position position;

  const TrainingState(this.duration, this.distance, this.position);

  @override
  List<Object> get props => [duration, distance, position];
}

class TrainingInitial extends TrainingState {
  TrainingInitial(int duration, double distance, Position position) : super(duration, distance, position);

  @override
  String toString() => 'TrainingInitial { duration: $duration distance: $distance position: $position  }';
}

class TrainingRunPause extends TrainingState {
  const TrainingRunPause(int duration, double distance, Position position) : super(duration, distance, position);

  @override
  String toString() => 'TrainingRunPause { duration: $duration distance: $distance position: $position  }';
}

class TrainingRunInProgress extends TrainingState {
  const TrainingRunInProgress(int duration, double distance, Position position) : super(duration, distance, position);

  @override
  String toString() => 'TrainingRunInProgress { duration: $duration distance: $distance position: $position }';
}

class TrainingRunComplete extends TrainingState {
  const TrainingRunComplete(int duration, double distance, Position position) : super(0, 0.0, null);
}
