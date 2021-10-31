import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';

class TaskTile extends StatelessWidget {
  TaskTile(this.index);
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskListManager>(
        builder: (context, taskListManager, child) {
      var task = taskListManager.taskList[index!];
      return ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) => taskListManager.checkboxToggle(task),
          activeColor: Colors.green,
        ),
      );
    });
  }
}
