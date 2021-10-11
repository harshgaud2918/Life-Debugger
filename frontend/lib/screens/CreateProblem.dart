import 'package:flutter/material.dart';
import 'package:life_debugger/Django%20API/rest_api.dart';
import 'package:life_debugger/data/Location.dart';
import 'package:life_debugger/data/ProblemObj.dart';
import 'package:life_debugger/data/User.dart';
import 'package:life_debugger/data/dummy.dart';
import 'package:life_debugger/shared/constant.dart';
import 'package:life_debugger/shared/loading.dart';
class CreateProblem extends StatefulWidget {
  CreateProblem({Key? key, required this.current,required this.list,required this.loc}) : super(key: key);
  final current;
  final List<ProblemObj> list;
  final LocationData loc;
  @override
  _CreateProblemState createState() => _CreateProblemState();
}

class _CreateProblemState extends State<CreateProblem> {
  int problemId=100;
  String description='';
  bool fetchingLocation=true;
  int severity=6;
  String summary='';
  bool loading=false;
  String? url;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return loading?Loading():Scaffold(
      appBar: AppBar(
        title: Text("Raise new Problem"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Form(
            key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Problem Summary[30 characters]'),
                    maxLength: 30,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }else{
                        summary=value;
                      }
                    },
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: textInputDecoration.copyWith(hintText: 'Problem Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }else{
                        description=value;
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Severity on a scale of 1-10'),
                    validator: (value){
                      if(value==null || value.isEmpty)
                        return 'Enter valid number';
                      else {
                        int? num = int.tryParse(value);
                        if(num==null || num<1 || num>10){
                          return 'Enter valid number';
                        }
                        else
                          severity=num;
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Image Google Drive link'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        url="https://i1.wp.com/leanprojectplaybook.com/wp-content/uploads/2017/07/Problem-Solution-Fit-64922822_xxl-Puzzle-Piece-e1499237044963.jpg?resize=1030%2C438";
                      }else{
                        url=createImageURL(value);
                      }
                    },
                  ),
                  SizedBox(height: 15,),
                  Text("Current Location will be fetched and used",style: TextStyle(fontSize: 15),),
                  SizedBox(height: 10,),
                  Text("Current Location is : "+widget.loc.state+"/"+widget.loc.city,style: TextStyle(fontSize: 15),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    child: Text(
                      'Submit Problem',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    //TODO: Proper Problem submission
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading=true;
                        });
                        ProblemObj created=ProblemObj(problemId: 100, summary: summary, description: description,severity: severity, valid: 0, invalid: 0, location: widget.loc, userId: widget.current.userId,url: url);
                        String resp = await createProblem(created);
                        print(resp);
                        if(resp!="0") {
                          widget.list.add(created);
                          setState(() {
                            Navigator.pop(context);
                          });
                        }else if(resp=="0"){
                          setState(() {
                            loading=false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Couldnt create problem"),
                              ),
                            );
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}
