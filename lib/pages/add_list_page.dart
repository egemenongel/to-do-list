import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:to_do_list_with_provider/widgets/time_field.dart';
import 'package:to_do_list_with_provider/widgets/bottom_app_bar.dart';

class AddListPage extends StatefulWidget {
  AddListPage({Key? key}) : super(key: key);

  @override
  State<AddListPage> createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  final taskTitle = TextEditingController();
  final startTime = TextEditingController();
  final finishTime = TextEditingController();
  TimeOfDay parseTime(String time) {
    return TimeOfDay(
        hour: int.parse(time.split(":")[0]),
        minute: int.parse(time.split(":")[1][0] + time.split(":")[1][1]));
  }

  @override
  Widget build(BuildContext context) {
    var _taskListManager = Provider.of<TaskListManager>(context, listen: false);
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
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  controller: taskTitle,
                  decoration: InputDecoration(labelText: "New Task"),
                  autofocus: true,
                ),
                SizedBox(
                  height: 15,
                ),
                TimeField(
                  controller: startTime,
                  labelText: "Start Time",
                ),
                SizedBox(
                  height: 15,
                ),
                TimeField(
                  controller: finishTime,
                  labelText: "Finish Time",
                )
              ],
            )),
          ),
          ElevatedButton(
            onPressed: () {
              TaskModel task = TaskModel(
                title: taskTitle.text,
                // startTime: parseTime(startTime.text),
                startTime: startTime.text,
                finishTime: finishTime.text,
              );
              _taskListManager.addTask(task);
              taskTitle.clear();
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
                          onPressed: () => taskListManager.removeTask(task),
                        ),
                        subtitle: Text((task.startTime == null
                                    ? ""
                                    : "${task.startTime} - ") +
                                (task.finishTime == null
                                    ? ""
                                    : "${task.finishTime}")
                            // "${task.startTime!.format(context).split(" ")[0]} - ${task.finishTime!.format(context).split(" ")[0]}"
                            ),
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
