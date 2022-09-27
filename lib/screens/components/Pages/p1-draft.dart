import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/components/Pages/NavigateButton.dart';
import 'package:task/screens/components/Pages/OnMap.dart';
import 'package:task/screens/components/Pages/ATM_Page1.dart';
import 'package:task/screens/components/Pages/Branches.dart';
import 'package:task/screens/components/Pages/p4.dart';
import 'package:task/screens/components/Pages/p2.dart';
import 'package:task/screens/components/Pages/p3.dart';

class FourTabsScreen extends StatefulWidget {
  const FourTabsScreen({Key? key}) : super(key: key);

  @override
  State<FourTabsScreen> createState() => _FourTabsScreenState();
}

class _FourTabsScreenState extends State<FourTabsScreen> {
  @override
  // int _page = 3;

  // int pageIndex = 0;
  final Page1 p1 = Page1();
  final Page2 p2 = Page2();
  final Page3 p3 = Page3();
  final Page4 p4 = Page4();
  final Page5 p5 = Page5();

  Widget _showPage = new Page1();

  // Widget _pageSelector(int page) {
  //   switch (page) {
  //     case 0:
  //       return p1;

  //     case 1:
  //       return p2;
  //     case 2:
  //       return p3;
  //     case 3:
  //       return p4;
  //     case 4:
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
                onPressed: () {},
                icon: Icon(Icons.arrow_back)),
            actions: [
              IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const Navigation()),
                    // );
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
              labelColor: Colors.green,
              indicatorColor: Colors.green,
              tabs: [
                Tab(text: 'ATM'),
                Tab(text: 'Branches'),
                Tab(text: 'On Map'),
              ],
            ),
          ),
          body: TabBarView(
            children: [Page1(), Page5(), Navigation()],
          ),
        ));
  }
}
