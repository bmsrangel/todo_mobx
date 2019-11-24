import 'package:flutter/material.dart';
import 'package:todo_mobx/app/modules/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: TextTheme(
            caption: TextStyle(color: Colors.grey[700], fontSize: 14),
          )),
      home: HomeModule(),
    );
  }
}
