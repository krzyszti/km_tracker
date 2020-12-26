import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:km_tracker/blocs/training/training.dart';
import 'package:km_tracker/utils/utils.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';


class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  final Ticker _ticker;
  static const int _duration = 0;
  static const double _distance = 0;
  StreamSubscription<int> _tickerSubscription;

  double distance = 0;
  Position position ;

  TrainingBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker,
        super(TrainingInitial(_duration, _distance, null));

  @override
  void onTransition(Transition<TrainingEvent, TrainingState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<TrainingState> mapEventToState(
      TrainingEvent event,
      ) async* {
    if (event is TrainingStarted) {
      yield* _mapTrainingStartedToState(event);
    } else if (event is TrainingPaused) {
      yield* _mapTrainingPausedToState(event);
    } else if (event is TrainingResumed) {
      yield* _mapTrainingResumedToState(event);
    } else if (event is TrainingReset) {
      yield* _mapTrainingResetToState(event);
    } else if (event is TrainingTicked) {
      yield* _mapTrainingTickedToState(event);
    } else if (event is TrainingFinished) {
      yield* _mapTrainingFinishedToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<TrainingState> _mapTrainingStartedToState(TrainingStarted start) async* {
    position = await determinePosition();
    yield TrainingRunInProgress(start.duration, start.distance, position);

    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(TrainingTicked(duration: duration, distance: this.distance, position: this.position)));
  }

  Stream<TrainingState> _mapTrainingPausedToState(TrainingPaused pause) async* {
    if (state is TrainingRunInProgress) {
      _tickerSubscription?.pause();
      yield TrainingRunPause(state.duration, state.distance, state.position);
    }
  }

  Stream<TrainingState> _mapTrainingResumedToState(TrainingResumed resume) async* {
    if (state is TrainingRunPause) {
      position = await determinePosition();
      yield TrainingRunInProgress(state.duration, state.distance, position);
      _tickerSubscription?.resume();
    }
  }

  Stream<TrainingState> _mapTrainingResetToState(TrainingReset reset) async* {
    _tickerSubscription?.cancel();
    yield TrainingInitial(_duration, _distance, null);
  }

  Stream<TrainingState> _mapTrainingTickedToState(TrainingTicked tick) async* {
    if (tick.duration % 10 == 0) {
      final Position newPosition = await determinePosition();
      distance = state.distance + calculateDistance(newPosition, state.position);
      position = newPosition;
      yield TrainingRunInProgress(tick.duration, distance, position);
    } else {
      yield TrainingRunInProgress(tick.duration, tick.distance, tick.position);
    }
  }

  Stream<TrainingState> _mapTrainingFinishedToState(TrainingFinished finish) async * {
    yield TrainingRunComplete(state.duration, state.distance, state.position);
  }
}
