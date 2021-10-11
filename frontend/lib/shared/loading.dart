import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: SpinKitFoldingCube(
          color: Theme.of(context).buttonColor,
          size: 50.0,
        ),
      ),
    );
  }
}