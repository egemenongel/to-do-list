import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:to_do_list_with_provider/widgets/task_form.dart';
import 'package:to_do_list_with_provider/widgets/bottom_app_bar.dart';

class AddListPage extends StatelessWidget {
  AddListPage({Key? key}) : super(key: key);
  final taskTitle = TextEditingController();
  final startTime = TextEditingController();
  final finishTime = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final duration = TextEditingController();
  final dueDate = TextEditingController();
  final notes = TextEditingController();
  // TimeOfDay parseTime(String time) {
  //   return TimeOfDay(
  //       hour: int.parse(time.split(":")[0]),
  //       minute: int.parse(time.split(":")[1][0] + time.split(":")[1][1]));
  // }
  void _clearForm() {
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    var _taskListManager = Provider.of<TaskListManager>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
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
            TaskForm(
              formKey: _formKey,
              taskTitle: taskTitle,
              startTime: startTime,
              finishTime: finishTime,
              duration: duration,
              dueDate: dueDate,
              notes: notes,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  TaskModel task = TaskModel(
                    title: taskTitle.text,
                    startTime: startTime.text,
                    finishTime: finishTime.text,
                    duration: duration.text,
                    dueDate: dueDate.text,
                    isCompleted: false,
                    notes: notes.text,
                  );
                  _taskListManager.addTask(task);
                  _clearForm();
                }
              },
              child: Text("Add"),
            ),
            Container(
              height: 250,
              child: Consumer<TaskListManager>(
                  builder: (context, taskListManager, child) =>
                      ListView.builder(
                          itemCount: taskListManager.listLength,
                          itemBuilder: (BuildContext context, int index) {
                            var task = taskListManager.taskList[index];
                            return ListTile(
                              trailing: IconButton(
                                  icon: Icon(Icons.remove_circle),
                                  onPressed: () =>
                                      taskListManager.removeTask(task)),
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
        ),
      ),
      bottomNavigationBar: ListBottomBar(),
    );
  }
}
