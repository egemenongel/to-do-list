import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/models/list_container_model.dart';
import 'package:to_do_list_with_provider/models/to_do_model.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/pages/add_list_page.dart';
import 'package:to_do_list_with_provider/pages/home_page.dart';

class ListTitlePage extends StatefulWidget {
  ListTitlePage({Key? key}) : super(key: key);

  @override
  _ListTitlePage createState() => _ListTitlePage();
}

class _ListTitlePage extends State<ListTitlePage> {
  @override
  @override
  Widget build(BuildContext context) {
    GlobalKey _key = GlobalKey();
    var lisTitle = TextEditingController();
    var _listContainerModel =
        Provider.of<ListContainerModel>(context, listen: true);

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
                controller: lisTitle,
                decoration: InputDecoration(
                    labelText:
                        "List Title (ex: Shopping List, Daily To Do List)"),
              ),
              key: _key,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              ToDoModel toDoListModel = ToDoModel(listTitle: lisTitle.text);
              _listContainerModel.addList(toDoListModel);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddListPage()));
            },
            child: Text("Add"),
          ),
        ],
      )),
    );
  }
}
