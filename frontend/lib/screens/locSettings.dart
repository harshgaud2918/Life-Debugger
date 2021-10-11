import 'package:flutter/material.dart';
import 'package:life_debugger/Django%20API/rest_api.dart';
import 'package:life_debugger/data/Location.dart';
import 'package:life_debugger/data/ProblemObj.dart';
import 'package:life_debugger/shared/loading.dart';
import 'package:life_debugger/widgets/ProblemList.dart';

// ignore: must_be_immutable
class LocSettings extends StatefulWidget {
  LocSettings({Key? key,required this.list,required this.loc}) : super(key: key);
  List<ProblemObj> list;
  LocationData loc;
  @override
  _locSettingsState createState() => _locSettingsState();
}

class _locSettingsState extends State<LocSettings> {
  //TODO : Everything location
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return isLoading?Loading():Scaffold(
      appBar: AppBar(
        title: Text("Location Settings"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Current Location"),
              Text(widget.loc.state + '/'+widget.loc.city,style: TextStyle(fontSize: 20),),
              SizedBox(height: 20,),
              Text("Get Problems of:"),
              SizedBox(height: 10,),
              ToggleButtons(
                children: <Widget>[
                  Text("All"),
                  Text("In "+widget.loc.state),
                  Text("In "+widget.loc.city),
                ],
                onPressed: (int index) async{
                  var map={0:'all' , 1:widget.loc.state,2:widget.loc.city};
                  setState(() {
                    isLoading=true;
                  });
                  //var listnew=null;
                  var listnew = await getProblemsList(map[index]!);
                  if(listnew!=null){
                    widget.list=listnew;
                    setState(() {
                      Navigator.pop(context);
                    });
                  }else
                  setState(() {
                    isLoading=false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Some Error occurred"),
                        ),
                      );
                  });
                },
                isSelected: [false,false,false],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
