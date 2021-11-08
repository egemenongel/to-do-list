import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';
import 'package:to_do_list_with_provider/services/database_service.dart';
import 'package:to_do_list_with_provider/widgets/task_list_tile.dart';

class TaskListsPage extends StatelessWidget {
  const TaskListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firestore = DatabaseService();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Lists"),
      ),
      body: StreamBuilder(
        stream: firestore.listsCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var list = snapshot.data.docs[index];
              return TaskListTile(list: list);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 10,
                color: Colors.pink[100],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.add_box_outlined),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListTitlePage()));
        },
      ),
    );
  }
}
