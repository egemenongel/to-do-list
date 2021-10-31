import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';

class TaskTile extends StatelessWidget {
  TaskTile(this.index, this.taskListManager);
  final int? index;
  final TaskListManager taskListManager;
  @override
  Widget build(BuildContext context) {
    var task = taskListManager.taskList[index!];
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted!
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) => taskListManager.checkboxToggle(task),
        activeColor: Colors.green,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.remove_circle_outline,
        ),
        onPressed: () => taskListManager.removeTaskAt(index),
      ),
    );
  }
}
