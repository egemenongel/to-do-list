import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/services/database_service.dart';
import 'package:to_do_list_with_provider/widgets/task_form.dart';

class AddTaskDialog extends StatelessWidget {
  AddTaskDialog({Key? key, required this.list}) : super(key: key);
  final DocumentSnapshot? list;
  final DatabaseService firestore = DatabaseService();
  final taskTitle = TextEditingController();
  final startTime = TextEditingController();
  final finishTime = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final duration = TextEditingController();
  final dueDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple[200],
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.deepPurple,
          )),
      content: SingleChildScrollView(
        child: TaskForm(
          formKey: _formKey,
          taskTitle: taskTitle,
          startTime: startTime,
          finishTime: finishTime,
          duration: duration,
          dueDate: dueDate,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                firestore.addTask(
                    list!.reference,
                    TaskModel(
                      title: taskTitle.text,
                      isCompleted: false,
                      startTime: startTime.text,
                      finishTime: finishTime.text,
                      duration: duration.text,
                      dueDate: dueDate.text,
                      timeStamp: Timestamp.now(),
                    ));
                Navigator.pop(context);
              }
            },
            child: Text("Add")),
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel"))
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
