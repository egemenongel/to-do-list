import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';
import 'package:to_do_list_with_provider/widgets/task_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "${context.read<TaskListManager>().listTitle}",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Consumer<TaskListManager>(
                builder: (_, taskListManager, child) => ListView.builder(
                    itemCount: taskListManager.listLength,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskTile(index, taskListManager);
                    }),
              ),
            ),
          ],
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
