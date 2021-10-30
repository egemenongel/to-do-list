import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/pages/add_list_page.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';

class ListTitlePage extends StatelessWidget {
  ListTitlePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var listTitle = TextEditingController();
    var _taskListManager = Provider.of<TaskListManager>(context, listen: false);
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            "TO DO LIST",
            style: TextStyle(fontSize: 35, color: Colors.green[700]),
          ),
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              child: TextFormField(
                controller: listTitle,
                decoration: InputDecoration(
                    labelText:
                        "List Title (Shopping List, Daily To Do List...)",
                    labelStyle: TextStyle(fontSize: 14)),
                autofocus: true,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              _taskListManager.setTitle(listTitle.text);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddListPage()));
            },
            child: Text("Next"),
          ),
        ],
      )),
    );
  }
}
