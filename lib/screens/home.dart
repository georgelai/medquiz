import 'package:flutter/material.dart';
import 'meds.dart';
import 'rewards.dart';
import 'games.dart';
import 'bookmarks.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<String> _myLabels = [
    'My Meds',
    'Rewards',
    'Games',
    'Bookmarks'
  ];

  final List<Widget> _children = [
    Meds(title: 'My Meds',),
    Rewards(title: 'Rewards'),
    Games(title: 'Games'),
    Bookmarks(title: 'Bookmarks'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_myLabels[_currentIndex]),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pharmacy),
            title: Text('My Meds'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            title: Text('Rewards'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset),
              title: Text('Games')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark),
              title: Text('Bookmarks'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}