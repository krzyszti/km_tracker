import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:km_tracker/blocs/trainings/trainings.dart';
import 'package:km_tracker/widgets/widgets.dart';

class TrainingsList extends StatelessWidget {
  TrainingsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingsBloc, TrainingsState>(
      builder: (context, state) {
        if (state is TrainingsLoadInProgress) {
          return LoadingIndicator();
        } else if (state is TrainingsLoadSuccess) {
          final trainings = state.trainings;
          if (trainings.isNotEmpty) {
          return ListView.builder(
            itemCount: trainings.length,
            itemBuilder: (BuildContext context, int index) {
              final training = trainings[index];
              print(training);
              return TrainingItem(
                training: training,
              );
            },
          ); } else {
            return Container(child: Center(child: Text('No trainings yet')));
          }
        } else {
          return Container();
        }
      },
    );
  }
}