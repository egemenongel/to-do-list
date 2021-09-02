import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/models/list_container_model.dart';
import 'package:to_do_list_with_provider/models/to_do_model.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var _listContainerModel =
        Provider.of<ListContainerModel>(context, listen: true);
    // var _containerIndex = _listContainerModel.listContainer.length - 1;

    var _listContainer = _listContainerModel.listContainer;
    var _toDoListModel = ToDoModel(listTitle: "");
    int taskIndexSetter() {
      if (_listContainerModel.listContainer.isNotEmpty) {
        return _listContainerModel.listContainer[0].taskList.length;
      }
      return 0;
    }

    int listIndexSetter() {
      if (_listContainer.isNotEmpty) {
        return _listContainer.length - 1;
      }
      return 0;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListTitlePage()));
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "TO DO LIST",
            style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          // Container(
          //   height: 100,
          //   child: ListView.builder(
          //       itemCount: _toDoListModel.taskList.length,
          //       itemBuilder: (BuildContext context, int index) => ListTile(
          //             onTap: () {},
          //             trailing: IconButton(
          //               icon: Icon(Icons.remove_circle),
          //               onPressed: () {
          //                 _toDoListModel.removeTaskAt(index);
          //               },
          //             ),
          //             title: Row(
          //               children: [
          //                 Text((index + 1).toString() + ". "),
          //                 Text((() {
          //                   if (_toDoListModel.taskList.isNotEmpty) {
          //                     return _toDoListModel.taskList[index].task;
          //                   }

          //                   return "";
          //                 })()),
          //               ],
          //             ),
          //             leading: Checkbox(
          //                 onChanged: (bool? value) {
          //                   setState(() {
          //                     _toDoListModel.taskList[index].isCompleted =
          //                         value!;
          //                   });
          //                 },
          //                 value: _toDoListModel.taskList[index].isCompleted),
          //           )),
          // ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              // Container(
              //     width: 100,
              //     height: 400,
              //     child: ListView.builder(
              //       itemCount: _listContainer.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         if (_listContainerModel.listContainer[listIndexSetter()]
              //             .listTitle.isNotEmpty) {
              //           return ListTile(
              //             title: TextButton(
              //               onPressed: () {},
              //               child: Text(_listContainer[index].listTitle),
              //             ),
              //           );
              //         }
              //         return SizedBox();
              //       },
              //     )),
              Container(
                margin: EdgeInsets.only(left: 60),
                child: Column(
                  children: [
                    Text(
                      _listContainerModel.listContainer[0].listTitle,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    Container(
                      width: 200,
                      height: 400,
                      child: ListView.builder(
                          itemCount: _listContainer[0].taskList.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (_listContainer.isNotEmpty) {
                              return ListTile(
                                title: Text(
                                    _listContainer[0].taskList[index].task),
                                leading: Checkbox(
                                    activeColor: Colors.green,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _listContainer[0]
                                            .taskList[index]
                                            .isCompleted = value!;
                                      });
                                    },
                                    value: _listContainer[0]
                                        .taskList[index]
                                        .isCompleted),
                              );
                            }

                            return SizedBox();
                          }),
                    ),
                  ],
                ),
              ),

              // Container(
              //   margin: EdgeInsets.only(right: 30),
              //   width: 150,
              //   height: 250,
              //   child: ListView.builder(
              //       itemCount: _toDoListModel.taskList.length,
              //       itemBuilder: (BuildContext context, int index) => ListTile(
              //           title: Text(_toDoListModel.taskList[index].task))),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
