import 'package:flutter/material.dart';
import 'package:life_debugger/data/ProblemObj.dart';
import 'package:life_debugger/data/User.dart';
import 'package:life_debugger/shared/problemExpanded.dart';

class Problem extends StatefulWidget {
  Problem({Key? key,required this.prob,required this.mod,required this.upVoted,required this.downVoted}) : super(key: key);
  ProblemObj prob;
  List<int> upVoted;
  List<int> downVoted;
  bool mod;
  @override
  _ProblemState createState() => _ProblemState();
}

class _ProblemState extends State<Problem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProblemExpanded(selected: widget.prob,mod: widget.mod,upVoted: widget.upVoted,downVoted: widget.downVoted,)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),

        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.only(left: 10,top: 10,bottom: 10,right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(widget.prob.location!.state+'/'+widget.prob.location!.city,style: TextStyle(fontSize: 15),),
                  SizedBox(height: 4,),
                  Divider(thickness: 4,),
                  SizedBox(height: 4,),
                  Text(widget.prob.summary,style: TextStyle(fontSize: 25),)
                ],
          ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(this.widget.prob.valid.toString(),style: TextStyle(fontSize: 20,color: Colors.green)),
                SizedBox(height: 10,),
                Text(this.widget.prob.invalid.toString(),style: TextStyle(fontSize: 20,color: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
