import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:km_tracker/repository/training_entity.dart';
import 'package:km_tracker/repository/training_repository.dart';
import 'package:meta/meta.dart';
import 'package:km_tracker/blocs/trainings/trainings.dart';
import 'package:km_tracker/models/models.dart';

class TrainingsBloc extends Bloc<TrainingsEvent, TrainingsState> {
  final TrainingsRepository trainingsRepository;

  TrainingsBloc({@required this.trainingsRepository})
      : super(TrainingsLoadInProgress());

  @override
  Stream<TrainingsState> mapEventToState(TrainingsEvent event) async* {
    if (event is TrainingsLoaded) {
      yield* _mapTrainingsLoadedToState();
    } else if (event is TrainingAdded) {
      yield* _mapTrainingAddedToState(event);
    }
  }

  Stream<TrainingsState> _mapTrainingsLoadedToState() async* {
    try {
      final List<TrainingEntity> trainings = await this.trainingsRepository.loadTrainings();
      yield TrainingsLoadSuccess(
        trainings.map(Training.fromEntity).toList(),
      );
    } catch (_) {
      yield TrainingsLoadFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingAddedToState(TrainingAdded event) async* {
    if (state is TrainingsLoadSuccess) {
      final List<Training> updatedTrainings =
      List.from((state as TrainingsLoadSuccess).trainings)
        ..add(event.training);
      try {
        await _saveTrainings(event.training);
        yield TrainingsLoadSuccess(updatedTrainings);
      } catch (_) {
        TrainingCreateFailure();
      }
    }
  }

  Future<void> _saveTrainings(Training training) async {
    trainingsRepository.saveTraining(
        training.toEntity()
    );
  }
}
