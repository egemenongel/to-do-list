import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var _taskListManager = Provider.of<TaskListManager>(
      context,
      listen: false,
    );
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
                  child: Consumer<TaskListManager>(
                      builder: (_, taskListManager, __) {
                    return ListView.builder(
                        itemCount: taskListManager.taskList.length,
                        itemBuilder: (BuildContext context, int index) {
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
                              value: task.isCompleted,
                              onChanged: (value) =>
                                  _taskListManager.checkboxToggle(task),
                              activeColor: Colors.green,
                            ),
                          );
                        });
                  })),
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
