import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String title;
  bool? isCompleted;
  String? startTime;
  String? finishTime;
  String? duration;
  String? dueDate;
  String? notes;
  Timestamp? timeStamp;

  TaskModel({
    required this.title,
    this.startTime,
    this.finishTime,
    this.duration,
    this.isCompleted,
    this.timeStamp,
    this.dueDate,
    this.notes,
  }) {
    this.title = title;
    this.isCompleted = isCompleted;
    this.startTime = startTime;
    this.finishTime = finishTime;
    this.duration = duration;
    this.timeStamp = timeStamp;
    this.dueDate = dueDate;
    this.notes = notes;
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
      "dueDate": dueDate,
      "timeStamp": timeStamp,
      "notes": notes,
    };
  }

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map["title"],
      isCompleted: map["isCompleted"],
      startTime: map["startTime"],
      finishTime: map["finishTime"],
      duration: map["duration"],
      dueDate: map["dueDate"],
      timeStamp: map["timeStamp"],
      notes: map["notes"],
    );
  }
}
