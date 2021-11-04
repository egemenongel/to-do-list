import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/widgets/task_form.dart';

class EditDialog extends StatelessWidget {
  EditDialog({Key? key}) : super(key: key);
  final taskTitle = TextEditingController();
  final startTime = TextEditingController();
  final finishTime = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final durationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Edit Task",
      ),
      content: TaskForm(
        formKey: _formKey,
        taskTitle: taskTitle,
        startTime: startTime,
        finishTime: finishTime,
        duration: durationController,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      actions: [
        TextButton(onPressed: () {}, child: Text("Edit")),
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel"))
      ],
    );
  }
}
