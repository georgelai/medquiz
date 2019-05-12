import 'package:flutter/material.dart';

class Bookmarks extends StatelessWidget {
  String title;

  Bookmarks({this.title});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text(title),
    );
  }

}