import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';

class TaskTile extends StatelessWidget {
  TaskTile(
      {this.index,
      required this.taskTitle,
      required this.isCompleted,
      required this.checkboxCallback,
      required this.removeCallback});
  final int? index;
  final String taskTitle;
  final bool isCompleted;
  final void Function(bool?)? checkboxCallback;
  final VoidCallback removeCallback;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration:
              isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      leading: Checkbox(
        value: isCompleted,
        onChanged: checkboxCallback,
        activeColor: Colors.green,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.remove_circle_outline,
        ),
        onPressed: removeCallback,
      ),
    );
  }
}
