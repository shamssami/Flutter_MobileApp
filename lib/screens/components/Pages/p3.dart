import 'package:flutter/material.dart';

import 'ATM.dart';

class Page3 extends StatefulWidget {
  Page3({Key? key}) : super(key: key);

  @override
  _Page3State createState() => new _Page3State();
}

class _Page3State extends State<Page3> {
  TextEditingController editingController = TextEditingController();

  final duplicateItems = <ATM>[
    ATM(name: 'Al-Ahlya', distance: '100 m', status: 'online'),
    ATM(name: 'Al-Ajma', distance: '200 m', status: 'ofline'),
    ATM(name: 'Al-Maysoun', distance: '300 m', status: 'online'),
  ];
  var items = <ATM>[];

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<ATM> dummySearchList = <ATM>[];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<ATM> dummyListData = <ATM>[];
      dummySearchList.forEach((item) {
        if (item.name.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 252, 249),
        body: Container(
            // height: 400,
            // margin: EdgeInsets.only(bottom: 10, right: 5, left: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 224, 225, 224).withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            // padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   '${duplicateItems[index].atmName}',
                    //   style:
                    //       TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    Expanded(
                      child: Text(
                        'It is ',
                        // style: TextStyle(fontSize: 58),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // new
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '22222',
                        style: TextStyle(color: Colors.red),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // new
                      ),
                    ),
                    // Text(
                    //   '${duplicateItems[index].atmDistance}',
                    //   style: TextStyle(color: Colors.red),
                    // ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                            // <-- Icon
                            Icons.fiber_manual_record,
                            size: 15.0,
                            color: Colors.green),
                        // SizedBox(
                        //   width: 5,
                        // ),
                        Text(
                          'online',
                          style: TextStyle(color: Colors.green),
                        ), // <-- Text
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  TextButton.icon(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      // fixedSize: MaterialStateProperty.all<Size>(
                      //     Size(95, 40)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 5, 116, 48)),
                    ),
                    icon: Icon(
                      Icons.near_me,
                      color: Colors.white,
                      // size: 10,
                    ),
                    label: Text(
                      'Navigation',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                    onPressed: () async {
                      // Position currentPosition =
                      //     await _determinePosition();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           // Navigation(p: currentPosition)
                      //           const Navigation()),
                      // );
                      // print(
                      //     'p1-position---------------------------${currentPosition}');
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.money_outlined),
                      Icon(Icons.fingerprint),
                      Icon(Icons.document_scanner)
                    ],
                  )
                ])
              ],
            )));
  }
}
