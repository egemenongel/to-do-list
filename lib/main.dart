import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/theme/theme.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskListManager()),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
      title: 'Flutter Demo',
      theme: MyTheme.theme,
      home: ListTitlePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
