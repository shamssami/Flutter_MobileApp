import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/components/Pages/OnMap.dart';
import 'package:task/screens/components/Pages/ATM.dart';
import 'package:task/screens/components/Pages/Branches.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  int _page = 0;

  int pageIndex = 0;
  // final Page1 p1 = Page1();
  // final Page5 p5 = Page5();

  Widget _showPage = new ATMPage();

  // Widget _pageSelector(int page) {
  //   switch (page) {
  //     case 0:
  //       return p1;

  //     case 1:
  //       return p4;
  //     case 2:
  //       return p5;

  //     default:
  //       return new Container(
  //         child: new Center(
  //           child: Text('No Page Found'),
  //         ),
  //       );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          extendBody: true,
          backgroundColor: Color.fromARGB(235, 255, 255, 255),
          appBar: AppBar(
            leading: IconButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            actions: [
              IconButton(
                  onPressed: () {
                    // Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.window_outlined,
                    color: Colors.black,
                  ))
            ],
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'Locator',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            bottom: const TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Color.fromARGB(255, 0, 137, 80),
              indicatorColor: Color.fromARGB(255, 0, 137, 80),
              tabs: [
                Tab(text: 'ATM'),
                Tab(text: 'Branches'),
                Tab(text: 'On Map'),
              ],
            ),
          ),
          body: TabBarView(
            children: [ATMPage(), BranchPage(), onMap()],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: 2,
            // height: 60.0,
            items: <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: Color.fromARGB(255, 184, 183, 183),
              ),
              Icon(
                Icons.copy_outlined,
                size: 30,
                color: Color.fromARGB(255, 184, 183, 183),
              ),
              Icon(
                Icons.add,
                size: 30,
                color: Color.fromARGB(255, 184, 183, 183),
              ),
              Icon(
                Icons.folder,
                size: 30,
                color: Color.fromARGB(255, 184, 183, 183),
              ),
              Icon(
                Icons.settings,
                size: 30,
                color: Color.fromARGB(255, 184, 183, 183),
              ),
            ],
            color: Color.fromARGB(255, 250, 250, 250),
            buttonBackgroundColor: Color.fromARGB(255, 0, 137, 80),
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 400),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            letIndexChange: (index) => true,
          ),
        ));
  }
}
