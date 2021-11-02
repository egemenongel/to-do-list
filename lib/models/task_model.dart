import 'package:flutter/material.dart';

class TaskModel {
  String title;
  bool? isCompleted;
  String? startTime;
  String? finishTime;

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
