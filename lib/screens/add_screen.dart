import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:km_tracker/blocs/training/training.dart';
import 'package:km_tracker/utils/utils.dart';
import 'package:km_tracker/widgets/widgets.dart';

class AddTrainingScreen extends StatefulWidget {
  final OnSaveCallback onSave;

  AddTrainingScreen({
    Key key,
    @required this.onSave,
  }) : super(key: key);

  @override
  _AddTrainingScreen createState() => _AddTrainingScreen();
}

class _AddTrainingScreen extends State<AddTrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          BlocProvider.of<TrainingBloc>(context).add(TrainingReset());
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('New training'),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<TrainingBloc, TrainingState>(
                  builder: (context, state) => TrainingDistance(),
                ),
                BlocBuilder<TrainingBloc, TrainingState>(
                  builder: (context, state) => TrainingDuration(),
                ),
                BlocBuilder<TrainingBloc, TrainingState>(
                  buildWhen: (previousState, state) =>
                      state.runtimeType != previousState.runtimeType,
                  builder: (context, state) =>
                      TrainingActions(onSave: widget.onSave),
                ),
              ],
            ),
          ),
        ));
  }
}
