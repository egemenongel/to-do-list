import 'package:flutter/material.dart';

class TaskModel {
  String title;
  bool? isCompleted;
  TimeOfDay? startTime;
  TimeOfDay? finishTime;

  TaskModel({
    required this.title,
    this.startTime,
    this.finishTime,
    this.isCompleted,
  }) {
    this.title = title;
    this.isCompleted = false;
  }

  void toggle() {
    isCompleted = !isCompleted!;
  }
}
