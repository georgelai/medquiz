import 'package:flutter/material.dart';

class Games extends StatelessWidget {
  String title;

  Games({this.title});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text(title),
    );
  }


}