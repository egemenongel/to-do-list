import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/models/list_container_model.dart';
import 'package:to_do_list_with_provider/models/to_do_model.dart';

import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/pages/home_page.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ToDoModel(listTitle: "")),
        ChangeNotifierProvider(create: (_) => ListContainerModel(index: 0)),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: ListTitlePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
