import 'package:flutter/material.dart';
import 'package:life_debugger/authentication/Authenticate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'Life Debugger';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.black,
          accentColor: Colors.grey[800]),
      home: Authenticate(),
    );
  }
}