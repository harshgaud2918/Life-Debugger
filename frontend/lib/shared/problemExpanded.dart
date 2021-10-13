import 'package:flutter/material.dart';
import 'package:life_debugger/Django%20API/rest_api.dart';
import 'package:life_debugger/data/ProblemObj.dart';
import 'package:life_debugger/data/User.dart';

class ProblemExpanded extends StatefulWidget {
  ProblemExpanded({Key? key,required this.selected,required this.mod,required this.upVoted,required this.downVoted}) : super(key: key);
  ProblemObj selected;
  List<int> upVoted;
  List<int> downVoted;
  bool mod;
  @override
  _ProblemExpandedState createState() => _ProblemExpandedState();
}

class _ProblemExpandedState extends State<ProblemExpanded> {

  @override
  Widget build(BuildContext context) {
    bool up=widget.upVoted.contains(widget.selected.problemId);
    bool down=widget.downVoted.contains(widget.selected.problemId);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selected.summary,style: TextStyle(fontSize: 20),),
        elevation: 2.0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,top: 15,right: 20,bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(widget.selected.summary,style: TextStyle(fontSize: 25),),
            SizedBox(height: 10,),
            Text(widget.selected.location!.state+'/'+widget.selected.location!.city,style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Flexible(
              child: Container(
                child: ListView(
                  children: [
                    if(widget.selected.url!=null)Image.network(widget.selected.url),
                    SizedBox(height: 10,),
                    Text(widget.selected.description,style: TextStyle(fontSize: 25),),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (){
                  int changeUp=0,changeDown=0;
                  setState(() {
                  if(!up){
                    widget.selected.valid+=1;
                    changeUp=1;
                    widget.upVoted.add(widget.selected.problemId);
                    up=true;
                    if(down){
                      widget.selected.invalid-=1;
                      changeDown=-1;
                      widget.downVoted.remove(widget.selected.problemId);
                      down=false;
                    }
                  }else{
                    changeUp=-1;
                    widget.selected.valid-=1;
                    widget.upVoted.remove(widget.selected.problemId);
                    up=false;
                  }
                  });
                  updateProblem(widget.selected,changeUp,changeDown);
                } , icon: Icon(Icons.add),iconSize: 40,color: up?Colors.green:Colors.white,),
                Text(widget.selected.valid.toString(),style: TextStyle(fontSize: 20),),
                IconButton(onPressed: (){
                  int changeUp=0,changeDown=0;
                  setState(() {
                    if(!down){
                      widget.selected.invalid+=1;
                      changeDown=1;
                      widget.downVoted.add(widget.selected.problemId);
                      down=true;
                      if(up){
                        widget.selected.valid-=1;
                        changeUp=-1;
                        widget.upVoted.remove(widget.selected.problemId);
                        up=false;
                      }
                    }else{
                      changeDown=-1;
                      widget.selected.invalid-=1;
                      widget.downVoted.remove(widget.selected.problemId);
                      down=false;
                    }
                  });
                  updateProblem(widget.selected,changeUp,changeDown);
                }, icon: Icon(Icons.remove),iconSize: 40,color: down?Colors.red:Colors.white,),
                Text(widget.selected.invalid.toString(),style: TextStyle(fontSize: 20),),
                if(widget.mod)IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,))
              ],
            )
          ],
        ),
      ),
    );
  }
}
