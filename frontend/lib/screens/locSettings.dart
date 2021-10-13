import 'package:flutter/material.dart';
import 'package:life_debugger/Django%20API/rest_api.dart';
import 'package:life_debugger/data/Location.dart';
import 'package:life_debugger/data/ProblemObj.dart';
import 'package:life_debugger/shared/loading.dart';
import 'package:life_debugger/widgets/ProblemList.dart';

// ignore: must_be_immutable
class LocSettings extends StatefulWidget {
  LocSettings({Key? key,required this.list,required this.loc,required this.locType}) : super(key: key);
  List<ProblemObj> list;
  LocationData loc;
  int locType;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Current Location"),
              Text(widget.loc.state + '/'+widget.loc.city,style: TextStyle(fontSize: 20),),
              SizedBox(height: 20,),
              Text("Get Problems of:",style: TextStyle(fontSize: 30),),
              SizedBox(height: 10,),
              ToggleButtons(
                direction: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("All"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("In "+widget.loc.state),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("In "+widget.loc.city),
                  ),
                ],
                onPressed: (int index) async{
                  var map={0:'all' , 1:widget.loc.state,2:widget.loc.city};
                  setState(() {
                    isLoading=true;
                  });
                  var listnew = await getProblemsList(index,map[index]!);
                  widget.locType=index;
                  if(listnew!=null){
                    if(listnew.length==0){
                      setState(() {
                        isLoading=false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("No problems posted in this area"),
                          ),
                        );
                      });
                    }
                    else
                    setState(() {
                      Navigator.pop(context,[listnew,widget.locType,map[index]]);
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
