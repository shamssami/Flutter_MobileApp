import 'package:flutter/material.dart';
import 'package:task/screens/components/Pages/ATM.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:geolocator/geolocator.dart';

class Page5 extends StatefulWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  TextEditingController editingController = TextEditingController();
  bool isLoading = true;

  List<Branches> duplicateItems = [];
  var items = <Branches>[];
  List<double> distnaceList = [];
  double minNumber = 0;
  @override
  void initState() {
    // items.addAll(duplicateItems);
    super.initState();
    _getBranches();
  }

  Future<double> calculateDistance(lat1, lon1) async {
    Position place = await _determinePosition();
    double lat2 = place.altitude;
    double lon2 = place.longitude;
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    print('---Calculated-Distance----------------------------');
    double dist_result = 12742 * asin(sqrt(a));
    String num1 = dist_result.toStringAsFixed(2);
    return double.parse(num1);
  }

  _getBranches() async {
    print(
        '===========================Helllo in Branches===============================');
    var url1 = Uri.parse(
        'https://safambs.dev.pcnc2000.com:5443/api/Data/atmBranchList');

    var response = await http.get(url1);
    var jsonData = jsonDecode(response.body);

    for (var a in jsonData) {
      Branches branch =
          Branches(a['branchId'], a['branchAddress'], a['branchBin'], 0);

      var l1 = branch.branchBin.split(',');
      double lat = double.parse(l1[0]);
      double lon = double.parse(l1[0]);

      branch.branchDistance = await calculateDistance(lat, lon);
      distnaceList.add(branch.branchDistance);
      duplicateItems.add(branch);
      print('afterSet======================${branch.branchDistance}');
    }
    print('****************${distnaceList.length}****');

    minNumber = distnaceList.reduce(min);
    print('afterSet======================${duplicateItems.length}');
    print('minNum======================${minNumber}');
    print(
        '1 FIRST DIS IN LIST======================${duplicateItems[0].branchDistance}');

    print(
        '2 FIRST DIS IN LIST======================${duplicateItems[0].branchDistance}');
    setState(() {
      items.addAll(duplicateItems);

      isLoading = false;

      duplicateItems.sort((a, b) {
        return a.branchDistance.compareTo(b.branchDistance);
        //softing on numerical order (Ascending order by Roll No integer)
      });
      items.sort((a, b) {
        return a.branchDistance.compareTo(b.branchDistance);
        //softing on numerical order (Ascending order by Roll No integer)
      });
    });
  }

  void filterSearchResults(String query) {
    List<Branches> dummySearchList = <Branches>[];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<Branches> dummyListData = <Branches>[];
      dummySearchList.forEach((item) {
        if (item.branchName.contains(query)) {
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
    print(
        '====@@@@@@@@@@@@@@@@@@@@@@@@@@@@@===from searchmethod====@@@@@@@@=====${items.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: Container(
            margin: EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 224, 225, 224).withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    controller: editingController,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      label: ListTile(
                        title: Text(
                          'Search',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('serach products...'),
                        trailing: Icon(Icons.search),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 0, 137, 80),
                    ))
                  : Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12)),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 224, 225, 224)
                                                .withOpacity(0.4),
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      '${items[index].branchName}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                      maxLines: 1,
                                    ),
                                    ///////////////////////////////////////////////////
                                    subtitle: minNumber ==
                                            items[index].branchDistance
                                        ? Text(
                                            '${items[index].branchDistance} KM, Nearest Branch',
                                            style: TextStyle(color: Colors.red),
                                          )
                                        : Text(
                                            '${items[index].branchDistance} KM away',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 172, 172, 172),
                                            ),
                                          ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          // <-- Icon
                                          Icons.fiber_manual_record,
                                          size: 15.0,
                                          color:
                                              Color.fromARGB(255, 0, 137, 80),
                                        ),
                                        // SizedBox(
                                        //   width: 5,
                                        // ),
                                        Text(
                                          'open now',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 137, 80),
                                          ),
                                        ), // <-- Text
                                      ],
                                    ),
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 0, 137, 80),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 5,
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: TextButton.icon(
                                          style: ButtonStyle(
                                            fixedSize:
                                                MaterialStateProperty.all<Size>(
                                                    Size(95, 40)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              Color.fromARGB(255, 0, 137, 80),
                                            ),
                                          ),
                                          icon: Icon(
                                            Icons.near_me,
                                            color: Colors.white,
                                            // size: 10,
                                          ),
                                          label: Text(
                                            'Navigation',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(30),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 0.5),
                                              blurRadius: 1,
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: TextButton.icon(
                                          style: ButtonStyle(
                                            fixedSize:
                                                MaterialStateProperty.all<Size>(
                                                    Size(95, 40)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                          ),
                                          icon: Icon(
                                            Icons.call,
                                            color:
                                                Color.fromARGB(255, 0, 137, 80),
                                            // size: 10,
                                          ),
                                          label: Text(
                                            'Call',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 137, 80),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    )
                                  ],
                                ));
                          }))
            ])));

    //   ));
    // }));
  }
}

class Branches {
  final String branchId, branchName, branchBin;
  double branchDistance = 0;

  Branches(this.branchId, this.branchName, this.branchBin, this.branchDistance);
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error("Location permission denied");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied');
  }

  Position position = await Geolocator.getCurrentPosition();

  return position;
}
