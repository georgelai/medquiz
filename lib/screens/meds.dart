import 'package:flutter/material.dart';

class Meds extends StatelessWidget {
  String title;

  Meds({this.title});

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Text(title),
    );
  }

}