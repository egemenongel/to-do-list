import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/widgets/task_form.dart';

class EditDialog extends StatelessWidget {
  EditDialog({Key? key}) : super(key: key);
  final taskTitle = TextEditingController();
  final startTime = TextEditingController();
  final finishTime = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final duration = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.deepPurple,
          )),
      title: Text(
        "Edit Task",
      ),
      content: Container(
        height: 250,
        child: TaskForm(
          formKey: _formKey,
          taskTitle: taskTitle,
          startTime: startTime,
          finishTime: finishTime,
          duration: duration,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      actions: [
        TextButton(onPressed: () {}, child: Text("Edit")),
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel"))
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
