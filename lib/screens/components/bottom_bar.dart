import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:task/screens/components/Pages/ATM_Page1.dart';
import 'package:task/screens/components/Pages/p2.dart';
import 'package:task/screens/components/Pages/p3.dart';
import 'package:task/screens/components/Pages/p4.dart';
import 'package:task/screens/components/Pages/Branches.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;

  int pageIndex = 0;
  final Page1 p1 = Page1();
  final Page2 p2 = Page2();
  final Page3 p3 = Page3();
  final Page4 p4 = Page4();
  final Page5 p5 = Page5();

  Widget _showPage = new Page1();
  Widget _pageSelector(int page) {
    switch (page) {
      case 0:
        return p1;

      case 1:
        return p2;
      case 2:
        return p3;
      case 3:
        return p4;
      case 4:
        return p5;

      default:
        return new Container(
          child: new Center(
            child: Text('No Page Found'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: pageIndex,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _showPage = _pageSelector(index);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          child: _showPage,
        ));
  }
}
