import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:km_tracker/blocs/training/training.dart';

class TrainingDistance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: _distance(
        trainingBloc: BlocProvider.of<TrainingBloc>(context),
      ),
    );
  }

  Widget _distance({
    TrainingBloc trainingBloc,
  }) {
    String kilometers = (trainingBloc.state.distance / 1000).toStringAsFixed(2);
    return Text(
      '$kilometers km',
      style: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
