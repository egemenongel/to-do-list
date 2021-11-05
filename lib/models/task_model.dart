import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String title;
  bool? isCompleted;
  String? startTime;
  String? finishTime;
  String? duration;
  Timestamp? timeStamp;

  TaskModel({
    required this.title,
    this.startTime,
    this.finishTime,
    this.duration,
    this.isCompleted,
    this.timeStamp,
  }) {
    this.title = title;
    this.isCompleted = false;
    this.startTime = startTime;
    this.finishTime = finishTime;
    this.duration = duration;
    this.timeStamp = timeStamp;
  }

  void toggle() {
    isCompleted = !isCompleted!;
  }

  Map<String, dynamic> toMap() {
    //model to map
    return {
      "title": title,
      "isCompleted": isCompleted,
      "startTime": startTime,
      "finishTime": finishTime,
      "duration": duration,
      "timeStamp": timeStamp,
    };
  }

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map["title"],
      isCompleted: map["isCompleted"],
      startTime: map["startTime"],
      finishTime: map["finishTime"],
      duration: map["duration"],
      timeStamp: map["timeStamp"],
    );
  }
}
