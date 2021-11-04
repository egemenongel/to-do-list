import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/services/firestore.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:to_do_list_with_provider/widgets/time_field.dart';
import 'package:to_do_list_with_provider/widgets/bottom_app_bar.dart';

class AddListPage extends StatelessWidget {
  AddListPage({Key? key}) : super(key: key);
  final taskTitle = TextEditingController();
  final startTime = TextEditingController();
  final finishTime = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final durationController = TextEditingController();
  final OutlineInputBorder _border =
      OutlineInputBorder(borderRadius: BorderRadius.circular(10));
  // TimeOfDay parseTime(String time) {
  //   return TimeOfDay(
  //       hour: int.parse(time.split(":")[0]),
  //       minute: int.parse(time.split(":")[1][0] + time.split(":")[1][1]));
  // }
  void _clearForm() {
    taskTitle.clear();
    startTime.clear();
    finishTime.clear();
  }

  @override
  Widget build(BuildContext context) {
    var _taskListManager = Provider.of<TaskListManager>(context, listen: false);
    bool isEnabled = true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            "${_taskListManager.listTitle}",
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              controller: taskTitle,
                              decoration: InputDecoration(
                                  labelText: "New Task",
                                  border: _border,
                                  labelStyle:
                                      TextStyle(color: Colors.deepPurple)),
                              autofocus: true,
                              validator: (value) => value!.isEmpty
                                  ? "Please enter a task"
                                  : null),
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
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold),
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
                              enabled: isEnabled,
                              validator: (value) {
                                if (startTime.text.isNotEmpty ||
                                    finishTime.text.isNotEmpty) {
                                  isEnabled = false; //setState
                                }
                              },
                              decoration: InputDecoration(
                                  border: _border,
                                  labelText: "Duration",
                                  labelStyle:
                                      TextStyle(color: Colors.deepPurple)),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      )),
                )),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                TaskModel task = TaskModel(
                  title: taskTitle.text,
                  startTime: startTime.text,
                  finishTime: finishTime.text,
                  duration: durationController.text,
                );
                _taskListManager.addTask(task);
                _clearForm();
              }
            },
            child: Text("Add"),
          ),
          Expanded(
            child: Consumer<TaskListManager>(
                builder: (context, taskListManager, child) => ListView.builder(
                    itemCount: taskListManager.listLength,
                    itemBuilder: (BuildContext context, int index) {
                      var task = taskListManager.taskList[index];
                      return ListTile(
                        trailing: IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () => taskListManager.removeTask(task)),
                        // "${task.startTime!.format(context).split(" ")[0]} - ${task.finishTime!.format(context).split(" ")[0]}"
                        // ERROR VALIDATION SHOULD BE ADDED to check if start date is smaller than finish date.//
                        title: Row(
                          children: [
                            Text("${index + 1}. "),
                            Text(
                              task.title,
                            ),
                          ],
                        ),
                      );
                    })),
          ),
        ],
      )),
      bottomNavigationBar: ListBottomBar(),
    );
  }
}
