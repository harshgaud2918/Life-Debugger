import 'package:flutter/material.dart';
import 'package:life_debugger/Django%20API/rest_api.dart';
import 'package:life_debugger/data/Location.dart';
import 'package:life_debugger/data/ProblemObj.dart';
import 'package:life_debugger/data/User.dart';
import 'package:life_debugger/screens/CreateProblem.dart';
import 'package:life_debugger/screens/locSettings.dart';
import 'package:life_debugger/shared/loading.dart';
import 'package:life_debugger/widgets/Display.dart';
import 'package:life_debugger/widgets/ProblemList.dart';
import 'package:life_debugger/data/dummy.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key,required this.title,required this.currentUser,required this.pList,required this.pincode}) : super(key: key);
  final title;
  User currentUser;
  List<ProblemObj> pList;
  int locType=0;
  String locSort="all";
  String pincode;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(),),
        elevation: 2.0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            ProblemList(list: widget.pList, mod: widget.currentUser.mod,upVoted: widget.currentUser.upVoteList,downVoted: widget.currentUser.downVoteList,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (){comingSoon(context);
                }, icon: Icon(Icons.edit)),
                IconButton(onPressed: ()async{
                  setState(() {
                    loading=true;
                  });
                  LocationData? loc=await fetchLocation(this.widget.pincode);
                  if(loc!=null){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateProblem(current: widget.currentUser,list: widget.pList,loc: loc,)),
                  ).then((value){
                    setState(() {
                      loading=false;
                    });
                  });
                  }
                  else{
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Some Error occurred"),
                        ),
                      );
                      loading=false;
                    });
                  }

                },
                    icon: Icon(Icons.add)),
                IconButton(onPressed: (){showUserDetails(widget.currentUser, context);}, icon: Icon(Icons.person)),
                IconButton(onPressed: ()async{
                  setState(() {
                    loading=true;
                  });
                  LocationData? loc=await fetchLocation(this.widget.pincode);
                  if(loc!=null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LocSettings(list: widget.pList,loc: loc,locType:widget.locType,)),
                    ).then((value){setState(() {
                      loading=false;
                      if(value!=null && value[0]!=null) {
                        widget.pList = value[0];
                        widget.locType=value[1];
                        widget.locSort=value[2];
                      }
                    });});

                  }else{
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Some Error occurred"),
                        ),
                      );
                      loading=false;
                    });
                  }
                }, icon: Icon(Icons.location_on)),
                IconButton(onPressed: ()async{
                    setState(() {
                      loading=true;
                    });
                    List<ProblemObj>? list= await getProblemsList(widget.locType,widget.locSort);
                    setState(() {
                      loading=false;
                      if(list!=null){
                        widget.pList=list;
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Some Error occurred"),
                          ),
                        );
                      }
                    });
                }, icon: Icon(Icons.refresh)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
