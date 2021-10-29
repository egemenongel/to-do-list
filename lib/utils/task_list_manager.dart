import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';

class TaskListManager extends ChangeNotifier {
  String? listTitle;
  List<TaskModel> taskList = [];

  addTask(TaskModel taskModel) {
    taskList.add(taskModel);
    notifyListeners();
  }

  removeTaskAt(index) {
    taskList.removeAt(index);
    notifyListeners();
  }

  clearList() {
    taskList.clear();
    notifyListeners();
  }

  setTitle(String title) {
    listTitle = title;
    notifyListeners();
  }

  checkboxToggle(bool value) {
    value = !value;
    notifyListeners();
  }
}
