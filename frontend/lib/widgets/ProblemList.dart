import 'package:flutter/material.dart';
import 'package:life_debugger/data/ProblemObj.dart';
import 'package:life_debugger/shared/problem.dart';

class ProblemList extends StatefulWidget {
  ProblemList({Key? key,required this.list,required this.mod,required this.upVoted,required this.downVoted}) : super(key: key);
  final List<ProblemObj> list;
  final bool mod;
  List<int> upVoted;
  List<int> downVoted;
  @override
  _ProblemListState createState() => _ProblemListState();
}

class _ProblemListState extends State<ProblemList> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ListView.builder(
              itemCount: widget.list.length,
              scrollDirection: Axis.vertical,
              itemBuilder:(BuildContext context, int index){
                  ProblemObj curr=widget.list[index];
                  return Problem(prob: curr,mod: widget.mod,upVoted: widget.upVoted,downVoted: widget.downVoted,);
              }
            ),
          ),
        ));
  }
}
