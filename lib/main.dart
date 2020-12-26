import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:km_tracker/blocs/blocs.dart';
import 'package:km_tracker/repository/training_repository.dart';
import 'package:km_tracker/screens/screens.dart';
import 'package:km_tracker/utils/ticker.dart';

import 'blocs/bloc_observer.dart';
import 'models/models.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TrainingsBloc>(
          create: (context) {
            return TrainingsBloc(
              trainingsRepository: TrainingsRepository(),
            )..add(TrainingsLoaded());
          },
        ),
      ],
      child: TrainingApp(),
    ),
  );
}

class TrainingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KM tracker',
      routes: {
        '/': (context) {
          return HomeScreen();
        },
        '/add_training': (context) {
          return BlocProvider<TrainingBloc>(
              create: (context) => TrainingBloc(ticker: Ticker()),
              child: AddTrainingScreen(
                onSave: (distance) {
                  BlocProvider.of<TrainingsBloc>(context).add(
                    TrainingAdded(Training(distance: distance)),
                  );
                },
              ));
        },
      },
    );
  }
}
