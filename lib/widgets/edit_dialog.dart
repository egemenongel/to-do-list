import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/services/firestore.dart';
import 'package:to_do_list_with_provider/widgets/task_form.dart';

class EditDialog extends StatelessWidget {
  EditDialog({
    Key? key,
    required this.index,
  }) : super(key: key);
  final index;

  final FireStoreService firestore = FireStoreService();

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
        height: 350,
        child: StreamBuilder(
          stream: firestore.orderById.snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            //SET INITIAL VALUES
            var task = snapshot.data.docs[index];
            taskTitle.text = task["title"];
            startTime.text = task["startTime"];
            finishTime.text = task["finishTime"];
            duration.text = task["duration"];
            return Column(
              children: [
                TaskForm(
                  formKey: _formKey,
                  taskTitle: taskTitle,
                  startTime: startTime,
                  finishTime: finishTime,
                  duration: duration,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                TextButton(
                  onPressed: () {
                    firestore.editTask(task, taskTitle.text, startTime.text,
                        finishTime.text, duration.text);
                    Navigator.pop(context);
                  },
                  child: Text("a"),
                )
              ],
            );
          },
        ),
      ),
      actions: [
        // TextButton(onPressed: editCallback, child: Text("Edit")),
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel"))
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
