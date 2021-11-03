import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile({
    required this.taskTitle,
    required this.isCompleted,
    required this.checkboxCallback,
  });

  final String taskTitle;
  final bool isCompleted;
  final void Function(bool?)? checkboxCallback;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTitle,
        style: TextStyle(
            decoration:
                isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            decorationColor: Theme.of(context).primaryColor),
      ),
      leading: Checkbox(
        value: isCompleted,
        onChanged: checkboxCallback,
        activeColor: Colors.green,
      ),
    );
  }
}
