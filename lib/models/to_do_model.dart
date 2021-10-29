import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';

class ToDoModel extends ChangeNotifier {
  List<TaskModel> taskList = [];
  String listTitle;

  ToDoModel({required this.listTitle}) {
    this.listTitle = listTitle;
  }

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
}
