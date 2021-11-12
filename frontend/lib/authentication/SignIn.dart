import 'package:flutter/material.dart';
import 'package:life_debugger/Django%20API/rest_api.dart';
import 'package:life_debugger/data/ProblemObj.dart';
import 'package:life_debugger/data/User.dart';
import 'package:life_debugger/screens/home.dart';
import '../shared/constant.dart';
import 'package:life_debugger/shared/loading.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email='',password='',error='', pincode="";

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0.0,
        title: Text(
          'Signin fellow Debugger!',
        ),
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Theme.of(context).iconTheme.color,
            ),
            label: Text('Register',
              style: TextStyle(
                  color: Theme.of(context).iconTheme.color
              ),),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                onChanged: (val){
                  setState(() {
                    email=val;
                  });
                },
                validator: (val)=>val!.isEmpty?'Enter an email':null,
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                onChanged: (val){
                  password=val;
                },
                obscureText: true,
                validator: (val)=>val!.length<=3?'Enter a password 3+ char long':null,
              ),
              SizedBox(height: 20,),

              //TODO:Temporary pincode loc
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Pincode'),
                onChanged: (val) {
                  setState(() {
                    pincode= val;
                  });
                },
                validator: (val) => val!.length!=6? 'Enter a valid incode' : null,
              ),

              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                //TODO: Proper sign in
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    User? curr=await fetchUser(email,password);
                    List<ProblemObj>? list= await getProblemsList(0,"all");
                    setState(() {
                      loading=false;
                      if(list!=null && curr!=null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              HomeScreen(title: "Life Debugger",
                                currentUser: curr,
                                pList: list,
                              pincode: pincode,)),
                        );
                      }
                      else
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Some Error occurred"),
                        ),
                      );
                    });
                  }
                },
              ),
              SizedBox(height: 20,),
              Text(error,
                style: TextStyle(
                    color:  Colors.red,
                    fontSize: 14.0
                ),
              ),
            ],
          ),
        ),
        decoration: razer_bg,
      ),
    );
  }
}
