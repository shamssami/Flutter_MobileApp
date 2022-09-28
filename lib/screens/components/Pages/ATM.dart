import 'package:flutter/material.dart';
import 'package:task/screens/components/Pages/NavigateMap.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:geolocator/geolocator.dart';

class ATMPage extends StatefulWidget {
  ATMPage({Key? key}) : super(key: key);

  @override
  _ATMPageState createState() => new _ATMPageState();
}

class _ATMPageState extends State<ATMPage> {
  bool isLoading = true;

  TextEditingController editingController = TextEditingController();
  List<ATMs> duplicateItems = [];
  var items = <ATMs>[];
  List<double> distnaceList = [];
  double minNumber = 0;
  @override
  void initState() {
    super.initState();
    _getATMs();
  }

  Future<double> calculateDistance(lat1, lon1) async {
    Position place = await _determinePosition();
    double lat2 = place.altitude;
    double lon2 = place.longitude;
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    double dist_result = 12742 * asin(sqrt(a));
    String num1 = dist_result.toStringAsFixed(2);
    return double.parse(num1);
  }

  _getATMs() async {
    var url1 =
        Uri.parse('https://safambs.dev.pcnc2000.com:5443/api/Data/atmList');

    var response = await http.get(url1);
    var jsonData = jsonDecode(response.body);

    for (var a in jsonData) {
      ATMs atm = ATMs(a['atmId'], a['atmAddress'], a['atmBin'], 0);
      print('beforeSet======================${atm.atmDistance}');

      var l1 = atm.atmBin.split(',');
      double lat = double.parse(l1[0]);
      double lon = double.parse(l1[0]);

      atm.atmDistance = await calculateDistance(lat, lon);
      distnaceList.add(atm.atmDistance);
      duplicateItems.add(atm);
      print('afterSet======================${atm.atmDistance}');
    }

    minNumber = distnaceList.reduce(min);
    print('afterSet======================${duplicateItems.length}');
    print('minNum======================${minNumber}');

    setState(() {
      items.addAll(duplicateItems);
      isLoading = false;
      duplicateItems.sort((a, b) {
        return a.atmDistance.compareTo(b.atmDistance);
      });

      items.sort((a, b) {
        return a.atmDistance.compareTo(b.atmDistance);
      });
    });
    print('_________________Data is Loaded____________________');
  }

  void filterSearchResults(String query) {
    List<ATMs> dummySearchList = <ATMs>[];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<ATMs> dummyListData = <ATMs>[];
      dummySearchList.forEach((item) {
        if (item.atmName.contains(query)) {
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
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: Container(
          margin: EdgeInsets.all(deviceWidth * 0.05),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                    // padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 224, 225, 224)
                              .withOpacity(0.4),
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
                  height: 20,
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
                            return Container(
                                margin: EdgeInsets.only(
                                    bottom: 12, right: 5, left: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 224, 225, 224)
                                          .withOpacity(0.4),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(16),
                                // child: FittedBox(
                                //     fit: BoxFit.cover,
                                //     child: Wrap
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(0),
                                          // width: 160,
                                          width: deviceWidth * 0.5,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${items[index].atmName}',
                                                  textAlign: TextAlign.start,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        0.033 * deviceWidth,

                                                    overflow: TextOverflow
                                                        .ellipsis, // new
                                                  ),
                                                ),
                                                minNumber ==
                                                        items[index].atmDistance
                                                    ? Text(
                                                        '${items[index].atmDistance} KM, Nearest ATM',
                                                        softWrap: false,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: // fontSize:
                                                                0.03 *
                                                                    deviceWidth,
                                                            color: Colors.red,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis))
                                                    : Text(
                                                        '${items[index].atmDistance} KM away',
                                                        softWrap: false,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: // fontSize:
                                                                0.03 *
                                                                    deviceWidth,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    192,
                                                                    192,
                                                                    192),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis)),
                                              ]),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              // <-- Icon
                                              Icons.fiber_manual_record,
                                              size: 14.0,
                                              color: Color.fromARGB(
                                                  255, 0, 137, 80),
                                            ),
                                            // SizedBox(
                                            //   width: 5,
                                            // ),
                                            Text(
                                              'online',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 137, 80),
                                                fontSize: // fontSize:
                                                    0.03 * deviceWidth,
                                              ),
                                            ), // <-- Text
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          TextButton.icon(
                                            style: ButtonStyle(
                                              // minimumSize:
                                              //     MaterialStateProperty.all<
                                              //         Size>(Size(60, 20)),
                                              maximumSize: MaterialStateProperty
                                                  .all<Size>(Size(
                                                      deviceWidth * 0.3,
                                                      deviceHight * 0.25)),
                                              // padding: MaterialStateProperty
                                              //     .all<EdgeInsets>(
                                              //         EdgeInsets.all(15)),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Color.fromARGB(
                                                          255, 0, 137, 80)),
                                            ),
                                            icon: Icon(
                                              Icons.near_me,
                                              color: Colors.white,
                                              size: deviceWidth * 0.03,
                                            ),
                                            label: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'Navigation',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          deviceWidth * 0.03,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )),
                                            onPressed: () async {
                                              var atmPosition = items[index]
                                                  .atmBin
                                                  .split(',');
                                              double currentLat =
                                                  double.parse(atmPosition[0]);
                                              double currentLon =
                                                  double.parse(atmPosition[1]);
                                              print(
                                                  '::::::::Navigate:::::::::::::::::::::');
                                              print(
                                                  '------currentLat----- ${currentLat}');
                                              print(
                                                  '------currentLong----- ${currentLon}');

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        // Navigation(p: currentPosition)
                                                        Navigation(
                                                          distance: items[index]
                                                              .atmDistance,
                                                          name: items[index]
                                                              .atmName,
                                                          binLat: currentLat,
                                                          binLon: currentLon,
                                                        )),
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Icon(Icons.money_outlined),
                                              Icon(Icons.fingerprint),
                                              Icon(Icons.document_scanner)
                                            ],
                                          )
                                        ])
                                  ],
                                ));
                            ;
                          },
                        ),
                      ),
              ],
            ),
          ),
        ));
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return Future.error('Location services are disabled.......');
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error("Location permission denied.......");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied......');
  }

  Position position = await Geolocator.getCurrentPosition();

  return position;
}

class ATMs {
  final String atmId, atmName, atmBin;
  double atmDistance = 0;
  ATMs(this.atmId, this.atmName, this.atmBin, this.atmDistance);
}
