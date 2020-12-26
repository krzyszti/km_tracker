import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:km_tracker/blocs/blocs.dart';
import 'package:km_tracker/widgets/trainings_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingsBloc, TrainingsState>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Trainings'),
          ),
          body: TrainingsList(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_training');
            },
            child: Icon(Icons.add),
            tooltip: 'New Training',
          ),
        );
      },
    );
  }
}
