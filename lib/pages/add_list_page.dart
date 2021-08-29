import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/models/list_container_model.dart';
import 'package:to_do_list_with_provider/models/to_do_model.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/pages/home_page.dart';

class AddListPage extends StatefulWidget {
  AddListPage({Key? key}) : super(key: key);

  @override
  _AddListPage createState() => _AddListPage();
}

class _AddListPage extends State<AddListPage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey _key = GlobalKey();
    var taskTitle = TextEditingController();
    var _listContainerModel =
        Provider.of<ListContainerModel>(context, listen: true);

    var _containerIndex = _listContainerModel.listContainer.length - 1;

    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            _listContainerModel.listContainer[_containerIndex].listTitle,
            style: TextStyle(fontSize: 35, color: Colors.green[700]),
          ),
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              child: TextFormField(
                controller: taskTitle,
                decoration: InputDecoration(labelText: "New Task"),
              ),
              key: _key,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                TaskModel task =
                    TaskModel(task: taskTitle.text, isCompleted: false);
                _listContainerModel.listContainer[_containerIndex]
                    .addTask(task);
              });
            },
            child: Text("Add"),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _listContainerModel
                    .listContainer[_containerIndex].taskList.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          setState(() {
                            _listContainerModel.listContainer[index]
                                .removeTaskAt(index);
                          });
                        },
                      ),
                      title: Row(
                        children: [
                          Text((index + 1).toString() + ". "),
                          Text(
                            _listContainerModel.listContainer[_containerIndex]
                                .taskList[index].task,
                          ),
                        ],
                      ),
                      // leading: Checkbox(
                      //     onChanged: (bool? value) {
                      //       setState(() {
                      //         _toDoListModel.taskList[index].isCompleted =
                      //             value!;
                      //       });
                      //     },
                      //     value: _toDoListModel.taskList[index].isCompleted),
                      // IconButton(
                      //     icon: ((() {
                      //       if (_toDoListModel
                      //               .taskList[index].isCompleted !=
                      //           true) {
                      //         return Icon(Icons.check_box_outline_blank);
                      //       }

                      //       return Icon(
                      //         Icons.check_box,
                      //         color: Colors.green,
                      //       );
                      //     })()),
                      //     onPressed: () {
                      //       setState(() {
                      //         if (_toDoListModel
                      //                 .taskList[index].isCompleted !=
                      //             true) {
                      //           _toDoListModel
                      //               .taskList[index].isCompleted = true;
                      //         } else {
                      //           _toDoListModel
                      //               .taskList[index].isCompleted = false;
                      //         }
                      //       });
                      //     }),
                    )),
          )
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      _listContainerModel.listContainer[_containerIndex]
                          .clearList();
                    });
                  },
                  child: Text("Clear List")),
            ),
            Container(height: 30, child: VerticalDivider(color: Colors.grey)),
            Expanded(
              child: Container(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: Text("Submit"))),
            )
          ],
        ),
      ),
    );
  }
}
