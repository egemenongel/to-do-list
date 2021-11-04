import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/widgets/time_field.dart';

class TaskForm extends StatelessWidget {
  TaskForm({
    Key? key,
    required this.formKey,
    required this.taskTitle,
    required this.startTime,
    required this.finishTime,
    required this.durationController,
    required this.border,
  }) : super(key: key);
  final GlobalKey formKey;
  final TextEditingController taskTitle;
  final TextEditingController startTime;
  final TextEditingController finishTime;
  final TextEditingController durationController;
  final OutlineInputBorder border;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
              controller: taskTitle,
              decoration: InputDecoration(
                  labelText: "New Task",
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  border: border),
              autofocus: true,
              validator: (value) =>
                  value!.isEmpty ? "Please enter a task" : null),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 110,
                child: TimeField(
                  controller: startTime,
                  labelText: "Start Time",
                ),
              ),
              Container(
                width: 110,
                child: TimeField(
                  controller: finishTime,
                  labelText: "Finish Time",
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    height: 20,
                    color: Colors.deepPurple,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 50,
                  child: Text(
                    "OR",
                    style: TextStyle(
                        color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Divider(
                    height: 20,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 100,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: durationController,
              // enabled: isEnabled,
              // validator: (value) {
              //   if (startTime.text.isNotEmpty ||
              //       finishTime.text.isNotEmpty) {
              //     isEnabled = false; //setState
              //   }
              // },
              decoration: InputDecoration(
                  labelText: "Duration",
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  border: border),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
