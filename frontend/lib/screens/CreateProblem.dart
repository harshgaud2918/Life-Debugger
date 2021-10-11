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
  String? url="https://drive.google.com/uc?export=view&id=1SsNVRNYDriv-NCXD0YnLRUlSFJynRcWi";
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return loading?Loading():Scaffold(
      appBar: AppBar(
        title: Text("Raise new Problem at current location"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
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
                  SizedBox(height: 10,),
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
                  SizedBox(height: 10,),
                  Text("Current Location will be fetched and used"),
                  Text("Current Location is : "+widget.loc.state+"/"+widget.loc.city),
                  SizedBox(height: 10,),
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
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Image Google Drive link'),
                    maxLength: 30,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                      }else{
                        url=createImageURL(value);
                      }
                    },
                  ),
                  SizedBox(height: 10,),
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
                        ProblemObj created=ProblemObj(problemId: 100, summary: summary, description: description,severity: 0, valid: 0, invalid: 0, location: widget.loc, userId: widget.current.userId,url: url);
                        //String resp = await createProblem(created);
                        widget.list.add(created);
                        //print(resp);
                        setState(() {
                          loading=false;
                          Navigator.pop(context);
                        });
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
