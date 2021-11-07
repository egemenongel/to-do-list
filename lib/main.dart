import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/pages/lists_page.dart';
import 'package:to_do_list_with_provider/theme/theme.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TaskListManager()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            builder: (context, child) => MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            ),
            title: 'Flutter Demo',
            theme: MyTheme.theme,
            home: ListsPage(),
            debugShowCheckedModeBanner: false,
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
