import 'package:flutter/material.dart';
import 'package:life_debugger/authentication/Authenticate.dart';
import 'package:life_debugger/data/User.dart';
import 'package:life_debugger/screens/home.dart';

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
      //home: Authenticate(),
      home: HomeScreen(currentUser: User(userId: 10, name: "BigBoi", email: 'xyz@bjp.ac.in', phoneNumber: "1289371928", password: 'password',mod: true,upVoteList: [],downVoteList: []), title: 'LifeDebugger',),
    );
  }
}