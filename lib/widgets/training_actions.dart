import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:km_tracker/blocs/training/training.dart';
import 'package:km_tracker/utils/callbacks.dart';

class TrainingActions extends StatelessWidget {
  final OnSaveCallback onSave;

  const TrainingActions({
    Key key,
    @required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
        trainingBloc: BlocProvider.of<TrainingBloc>(context),
        context: context,
      ),
    );
  }

  void _finishTraining(TrainingBloc trainingBloc, BuildContext context) {
    trainingBloc.add(TrainingFinished());
    onSave(trainingBloc.state.distance);
    Navigator.popAndPushNamed(context, '/');
  }

  List<Widget> _mapStateToActionButtons({
    TrainingBloc trainingBloc,
    BuildContext context,
  }) {
    final TrainingState currentState = trainingBloc.state;
    if (currentState is TrainingInitial) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {
            trainingBloc.add(TrainingStarted());
          },
        ),
      ];
    }
    if (currentState is TrainingRunInProgress) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => trainingBloc.add(TrainingPaused()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => trainingBloc.add(TrainingReset()),
        ),
        FloatingActionButton(
          child: Icon(Icons.stop),
          onPressed: () => _finishTraining(trainingBloc, context),
        ),
      ];
    }
    if (currentState is TrainingRunPause) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => trainingBloc.add(TrainingResumed()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => trainingBloc.add(TrainingReset()),
        ),
        FloatingActionButton(
          child: Icon(Icons.stop),
          onPressed: () => _finishTraining(trainingBloc, context),
        ),
      ];
    }
    if (currentState is TrainingRunComplete) {
      return [
        FloatingActionButton(
            child: Icon(Icons.replay),
            onPressed: () {
              trainingBloc.add(TrainingStarted());
            }),
      ];
    }
    return [];
  }
}
