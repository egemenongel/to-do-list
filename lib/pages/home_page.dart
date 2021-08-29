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
    @override
    var _listContainerModel =
        Provider.of<ListContainerModel>(context, listen: true);
    var _containerIndex = _listContainerModel.listContainer.length - 1;
    var _listIndex = 0;
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
          Text("TO DO LISTS"),
          SizedBox(
            height: 20,
          ),
          // Text(_listContainerModel.listContainer[0].taskList[0].task.toString()
          //     // ListView.builder(
          //     //     itemCount: _toDoListModel.taskList.length,
          //     //     itemBuilder: (BuildContext context, int index) => ListTile(
          //     //           onTap: () {},
          //     //           trailing: IconButton(
          //     //             icon: Icon(Icons.remove_circle),
          //     //             onPressed: () {
          //     //               _toDoListModel.removeTaskAt(index);
          //     //             },
          //     //           ),
          //     //           title: Row(
          //     //             children: [
          //     //               Text((index + 1).toString() + ". "),
          //     //               Text((() {
          //     //                 if (_toDoListModel.taskList.isNotEmpty) {
          //     //                   return _toDoListModel.taskList[index].task;
          //     //                 }

          //     //                 return "";
          //     //               })()),
          //     //             ],
          //     //           ),
          //     //           leading: Checkbox(
          //     //               onChanged: (bool? value) {
          //     //                 setState(() {
          //     //                   _toDoListModel.taskList[index].isCompleted = value!;
          //     //                 });
          //     //               },
          //     //               value: _toDoListModel.taskList[index].isCompleted),
          //     //         )),
          //     ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Container(
                  width: 100,
                  height: 400,
                  child: ListView.builder(
                      itemCount: _listContainerModel.listContainer.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ListTile(
                              title: TextButton(
                            onPressed: () {},
                            child: Text(_listContainerModel
                                .listContainer[index].listTitle),
                          )))),
              Container(
                margin: EdgeInsets.only(left: 60),
                child: Column(
                  children: [
                    Text(
                      _listContainerModel
                          .listContainer[_containerIndex].listTitle,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 150,
                      height: 400,
                      child: ListView.builder(
                          itemCount: _listContainerModel
                              .listContainer[_containerIndex].taskList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(_listContainerModel
                                  .listContainer[_containerIndex]
                                  .taskList[index]
                                  .task),
                              leading: Checkbox(
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _listContainerModel
                                          .listContainer[_containerIndex]
                                          .taskList[index]
                                          .isCompleted = value!;
                                    });
                                  },
                                  value: _listContainerModel
                                      .listContainer[_containerIndex]
                                      .taskList[index]
                                      .isCompleted),
                            );
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
