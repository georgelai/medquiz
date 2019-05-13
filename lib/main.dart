import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedQuiz',
      theme: ThemeData(

        primarySwatch: Colors.cyan,
        primaryColor: Colors.cyan[800],
      ),
      home: LoginScreen(),//MyHomePage(title: 'MedQuiz'),
      debugShowCheckedModeBanner: false,
    );
  }
}


