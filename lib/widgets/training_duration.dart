import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:km_tracker/blocs/training/training.dart';

class TrainingDuration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 100.0),
        child: Center(
          child: _distance(
            trainingBloc: BlocProvider.of<TrainingBloc>(context),
          ),
        ));
  }

  Widget _distance({
    TrainingBloc trainingBloc,
  }) {
    final String hourStr = ((trainingBloc.state.duration / (60 * 60)))
        .floor()
        .toString()
        .padLeft(2, '0');
    final String minutesStr = ((trainingBloc.state.duration / 60) % 60)
        .floor()
        .toString()
        .padLeft(2, '0');
    final String secondsStr =
        (trainingBloc.state.duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$hourStr:$minutesStr:$secondsStr',
    );
  }
}
