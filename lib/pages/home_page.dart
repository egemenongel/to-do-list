import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _taskListManager = Provider.of<TaskListManager>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "TO DO LIST",
            style: TextStyle(fontSize: 25),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "${_taskListManager.listTitle}",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 300,
                height: 400,
                child: ListView.builder(
                    itemCount: _taskListManager.taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Consumer<TaskListManager>(
                          builder: (context, taskListManager, child) {
                        var task = taskListManager.taskList[index];
                        return ListTile(
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          leading: Checkbox(
                            value: taskListManager.taskList[index].isCompleted,
                            onChanged: (value) =>
                                _taskListManager.checkboxToggle(task),
                            activeColor: Colors.green,
                          ),
                        );
                      });
                      //  ListTile(
                      //   title: Text(
                      //     task.title,
                      //     style: TextStyle(
                      //       decoration: task.isCompleted
                      //           ? TextDecoration.lineThrough
                      //           : TextDecoration.none,
                      //     ),
                      //   ),
                      //   leading: Checkbox(
                      //     value: task.isCompleted,
                      //     onChanged: (value) =>
                      //         _taskListManager.checkboxToggle(task),
                      //     activeColor: Colors.green,
                      //   ),
                      // );
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListTitlePage()));
        },
      ),
    );
  }
}
