import 'package:flutter/material.dart';
import 'package:task/screens/components/Pages/ATM_Page1.dart';
import 'package:task/screens/components/Pages/p2.dart';
import 'package:task/screens/components/Pages/p3.dart';
import 'package:task/screens/components/Pages/p4.dart';
import 'package:task/screens/components/Pages/Branches.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Locator extends StatefulWidget {
  const Locator({Key? key}) : super(key: key);

  @override
  State<Locator> createState() => _LocatorState();
}

class _LocatorState extends State<Locator> {
  int _page = 0;

  int pageIndex = 0;
  final Page1 p1 = Page1();
  final Page2 p2 = Page2();
  final Page3 p3 = Page3();
  final Page4 p4 = Page4();
  final Page5 p5 = Page5();

  Widget _showPage = new Page1();
  Widget _sectionSelector(int section) {
    switch (section) {
      case 0:
        return p1;

      case 1:
        return p2;
      case 2:
        return p3;

      default:
        return new Container(
          child: new Center(
            child: Text('No Page Found'),
          ),
        );
    }
  }

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
    Color _color = Colors.black;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88, //set your height
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            color: Colors.white, // set your color
            child: Column(
              children: [
                Row(children: [
                  IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
                  Spacer(),
                  Center(child: Text("Locator")), // set an icon or image
                  Spacer(),
                  IconButton(icon: Icon(Icons.menu), onPressed: () {}),
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                        child: Text(
                          'ATM',
                          style: TextStyle(color: _color),
                        ),
                        onTap: () {
                          print('Shaaaaaaaaaaaaaaaaamssss');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Page1()),
                          );
                          setState(() {
                            _color == Colors.green
                                ? _color = Colors.black
                                : _color = Colors.green;
                          });
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        behavior: HitTestBehavior.opaque),
                    Spacer(),
                    Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.green, width: 2))),
                        child: GestureDetector(
                            child: Text(
                              'Branches',
                              style: TextStyle(color: _color),
                            ),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const Page2()),
                              // );
                              print('Shaaaaaaaaaaaaaaaaamssss');

                              setState(() {
                                _color == Colors.green
                                    ? _color = Colors.black
                                    : _color = Colors.green;
                              });
                            },
                            behavior: HitTestBehavior.opaque)),
                    Spacer(),
                    Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.green, width: 2))),
                        child: GestureDetector(
                            child: Text(
                              'On Map',
                              style: TextStyle(color: _color),
                            ),
                            onTap: () {
                              print('Shaaaaaaaaaaaaaaaaamssss');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Page4()),
                              );
                              setState(() {
                                _color == Colors.green
                                    ? _color = Colors.black
                                    : _color = Colors.green;
                              });
                            },
                            behavior: HitTestBehavior.opaque))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
        buttonBackgroundColor: Color.fromARGB(255, 35, 176, 101),
        // backgroundColor: Color.fromARGB(26, 244, 241, 241),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _showPage = _pageSelector(index);
          });
        },
        letIndexChange: (index) => true,
      ),
      body: _showPage,
    );
  }
}
