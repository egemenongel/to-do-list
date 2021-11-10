import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';

class TaskListManager extends ChangeNotifier {
  String? listTitle;
  List<TaskModel> _taskList = [];
  bool duration = true;
  int total = 0;
  UnmodifiableListView<TaskModel> get taskList {
    return UnmodifiableListView(_taskList);
  }

  int get listLength {
    return _taskList.length;
  }

  addTask(TaskModel taskModel) {
    _taskList.add(taskModel);
    notifyListeners();
  }

  removeTask(taskModel) {
    _taskList.remove(taskModel);
    notifyListeners();
  }

  clearList() {
    _taskList.clear();
    notifyListeners();
  }

  setTitle(String title) {
    listTitle = title;
    notifyListeners();
  }

  checkboxToggle(TaskModel task) {
    task.toggle();
    notifyListeners();
  }

  changeBool(bool value) {
    duration = value;
    notifyListeners();
  }

  void sumDuration(dynamic list) {
    var sum = 0;
    for (DocumentSnapshot task in list) {
      if (task.get("isCompleted") == true) {
        if ((int.tryParse(task.get("duration"))) is int) {
          sum += int.parse(task.get("duration"));
        } else {
          sum = sum;
        }
        if ((task.get("startTime").toString().length > 1) &&
            task.get("finishTime").toString().length > 1) {
          sum +=
              durationCalculator(task.get("startTime"), task.get("finishTime"));
        } else {
          sum = sum;
        }
      }
    }
    total = sum;
  }

  // void durationCalculator(TimeOfDay start, TimeOfDay finish) {
  //   int startMinutes = start.hour * 60 + start.minute;
  //   int finishMinutes = finish.hour * 60 + finish.minute;
  //   int duration = finishMinutes - startMinutes;
  //   print(duration.toString());
  //   // If one of the date is given other should also given!
  //   // If duration is negative => ERROR
  //   // "${task.startTime!.format(context).split(" ")[0]} - ${task.finishTime!.format(context).split(" ")[0]}"
  //   // ERROR VALIDATION SHOULD BE ADDED to check if start date is smaller than finish date.//
  // }

  int durationCalculator(String startTime, String finishTime) {
    String startHours = startTime.split(":"[0])[0];
    String startMins = startTime.split(":"[0])[1];
    int startMinutes = int.parse(startHours) * 60 + int.parse(startMins);

    String finishHours = finishTime.split(":"[0])[0];
    String finishMins = finishTime.split(":"[0])[1];
    int finishMinutes = int.parse(finishHours) * 60 + int.parse(finishMins);
    int duration = finishMinutes - startMinutes;
    return duration;
  }
}
