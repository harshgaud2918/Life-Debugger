import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    fillColor: Colors.black87,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green,width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFF0000) ,width: 2.0),
    )
);

const razer_bg = BoxDecoration(
    image: DecorationImage(
        image: AssetImage('assets/images/India_Clean.png'),
        fit: BoxFit.cover
    )
);

String createImageURL(String ori){
  List sub=ori.split("/");
  if(sub.length<=2)
    return "https://i1.wp.com/leanprojectplaybook.com/wp-content/uploads/2017/07/Problem-Solution-Fit-64922822_xxl-Puzzle-Piece-e1499237044963.jpg?resize=1030%2C438";
  return "https://drive.google.com/uc?export=view&id="+sub[sub.length-2];
}