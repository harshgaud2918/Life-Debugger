import 'package:flutter/material.dart';
import 'package:life_debugger/Django%20API/rest_api.dart';
import 'package:life_debugger/data/ProblemObj.dart';
import 'package:life_debugger/data/User.dart';
import 'package:life_debugger/screens/home.dart';
import 'package:life_debugger/shared/constant.dart';
import 'package:life_debugger/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String name='',email = '',phoneNumber='', password = '', error = "";

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0.0,
        title: Text(
          'Signup to become a Debugger!',
        ),
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
            ),
            label: Text('Sign In',
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ListView(
          children: [
            Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  validator: (val) => val!.isEmpty ? 'Enter a name' : null,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email: username@xyz.com'),
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                ),
                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Phone Number'),
                  onChanged: (val) {
                    setState(() {
                      phoneNumber = val;
                    });
                  },
                  validator: (val) => val!.isEmpty ? 'Enter a phone number' : null,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  onChanged: (val) {
                    password = val;
                  },
                  obscureText: true,
                  validator: (val) =>
                  val!.length <= 6 ? 'Enter a password 6+ char long' : null,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  //TODO: Proper register
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      List<ProblemObj>? list= await getProblemsList("all");
                      User nw=User(userId: 5, name: name, email: email, phoneNumber: phoneNumber, password: password,mod: true,upVoteList: [],downVoteList: []);
                      setState(() {
                        loading=false;
                        if(list!=null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                HomeScreen(title: "Life Debugger",
                                  currentUser: nw,
                                  pList: list,)),
                          );
                        }
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ],
        ),
        decoration: razer_bg,
      ),
    );
    ;
  }
}
