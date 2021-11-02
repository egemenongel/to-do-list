import 'package:flutter/material.dart';

class TaskModel {
  String title;
  bool? isCompleted;
  TimeOfDay? startDate;
  TimeOfDay? finishDate;

  TaskModel({
    required this.title,
    this.startDate,
    this.finishDate,
    this.isCompleted,
  }) {
    this.title = title;
    this.isCompleted = false;
  }

  void toggle() {
    isCompleted = !isCompleted!;
  }
}
