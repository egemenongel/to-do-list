import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/pages/list_page.dart';
import 'package:to_do_list_with_provider/services/firestore.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';

class ListBottomBar extends StatelessWidget {
  ListBottomBar({Key? key}) : super(key: key);
  final int taskId = 0;
  final String? title = "";
  @override
  Widget build(BuildContext context) {
    var _taskListManager = Provider.of<TaskListManager>(context, listen: false);
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
                onPressed: () {
                  context.read<TaskListManager>().clearList();
                },
                child: Text("Clear List")),
          ),
          Container(
            height: 30,
            child: VerticalDivider(color: Colors.grey),
            width: 0,
          ),
          Expanded(
              child: TextButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    var firestore = FireStoreService();
                    firestore.addList(
                        _taskListManager.listTitle!, _taskListManager);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListPage(
                                  listTitle: _taskListManager.listTitle!,
                                )));
                    _taskListManager.clearList();
                  },
                  child: Text("Submit")))
        ],
      ),
    );
  }
}
