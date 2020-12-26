import 'package:flutter/material.dart';
import 'package:km_tracker/models/models.dart';

class TrainingItem extends StatelessWidget {
  final Training training;

  TrainingItem({
    Key key,
    @required this.training,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(this.training.totalDistance()),
        subtitle: Text(this.training.dateTime()),
    );
  }
}