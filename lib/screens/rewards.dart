import 'package:flutter/material.dart';

class Rewards extends StatelessWidget {
  String title;

  Rewards({this.title});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text(title),
    );
  }

}