import 'package:design_demo/screen/UsersPage.dart';
import 'package:design_demo/screen/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Routes/AppTheme.dart';
import 'FirstPage.dart';

int _selectedIndex = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    const List<Widget> _widgetOptions = <Widget>[
      FirstPage(),
      UsersPage(),
      SettingsPage(),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: kbackgroudColor,
        appBar: AppBar(
          backgroundColor:
              Colors.transparent, // Set the background color to transparent
          elevation: 0, // Set the elevation to 0
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kbackgroudColor,
          elevation: 10,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'First Page',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Details Page',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Settings Page',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.green,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
