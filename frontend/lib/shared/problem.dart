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
        ).then((value){
          setState(() {
          });
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),

        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 6,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(widget.prob.summary,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 24),),
                Divider(thickness: 1,color: Colors.grey),
                Text(widget.prob.location!.city+'/'+widget.prob.location!.state,style: TextStyle(fontSize: 15),),

              ],
          ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                  padding:EdgeInsets.all(10),
                  child: Image.network(widget.prob.url)
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.prob.valid.toString(),style: TextStyle(color: Colors.green,fontSize: 24),),
                  SizedBox(height: 10,),
                  Text(widget.prob.invalid.toString(),style: TextStyle(color: Colors.red,fontSize: 24),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
