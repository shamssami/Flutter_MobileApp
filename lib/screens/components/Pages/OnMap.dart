import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:label_marker/label_marker.dart';
import 'package:geolocator/geolocator.dart';

class onMap extends StatefulWidget {
  onMap({Key? key}) : super(key: key);
  @override
  State<onMap> createState() => onMapState();
}

class onMapState extends State<onMap> {
  // late BitmapDescriptor mapMarker;
  List<double> lati_ATM = [];
  List<double> longi_ATM = [];
  Set<Marker> myMarkers = {};
  // late BitmapDescriptor atm_black;
  Set<Marker> ListMarkers1 = {};
  Set<Marker> ListMarkers2 = {};

  List<double> lati_branch = [];
  List<double> longi_branch = [];
  Set<Marker> ListMarkers3 = {};
  Widget P = Container();

  @override
  void initState() {
    super.initState();
    print(
        'state@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@###############################');
    getATMsData();
    // setCustomeMarker();
  }

//////////////////////////////////////////////////////////////////
  _showMarkers() {
    setState(() {
      if (myMarkers == ListMarkers1) {
        myMarkers = ListMarkers2;
      } else {
        myMarkers = ListMarkers1;
      }
    });
  }

/////////////////////////////////////////////////////////////////
  getATMsData() async {
    print(
        'Method startttttttt@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@###############################');
    BitmapDescriptor atmbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/ATM_Mark.png");

    BitmapDescriptor branchbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(35, 40)),
        "assets/images/Branch_Mark.png");
    var url1 =
        Uri.parse('https://safambs.dev.pcnc2000.com:5443/api/Data/atmList');

    var url2 = Uri.parse(
        'https://safambs.dev.pcnc2000.com:5443/api/Data/atmBranchList');

    var response = await http.get(url1);
    var jsonData = jsonDecode(response.body);
    List<ATMs> atms = [];
    ///////////////////
    var response2 = await http.get(url2);
    var jsonData2 = jsonDecode(response2.body);
    List<Branches> branches = [];

    for (var a in jsonData) {
      ATMs atm = ATMs(a['atmId'], a['atmAddress'], a['atmBin']);

      atms.add(atm);
    }

    //////Branches
    for (var b in jsonData2) {
      Branches branch =
          Branches(b['branchId'], b['branchAddress'], b['branchBin']);

      branches.add(branch);
    }

    ///
    ///
    ///
    print(
        '*********************************************************************');
    print('ATM Length ${atms.length}');
    print('Branches Length ${branches.length}');

    for (var item = 0; item < atms.length; item++) {
      var l1 = atms[item].atmBin.split(',');
      lati_ATM.add(double.parse(l1[0]));
      longi_ATM.add(double.parse(l1[1]));
    }
/////branches
    for (var item = 0; item < branches.length; item++) {
      var b1 = branches[item].branchBin.split(',');
      lati_branch.add(double.parse(b1[0]));
      longi_branch.add(double.parse(b1[1]));
    }

    ///
    var atmMarkers = atms;
    var branchMarkers = branches;

    print(atms.length);
    Marker _ATMmarker;
    Marker _BranchMarker;

    print('1111111111jjjjjjjjjjjjjj');

    for (var item = 0; item < atmMarkers.length; item++) {
      _ATMmarker = Marker(
          markerId: MarkerId('${atmMarkers[item].atmId}'),
          infoWindow: InfoWindow(title: '${atmMarkers[item].atmName}'),
          icon: atmbitmap,
          position: LatLng(lati_ATM[item], longi_ATM[item]));
      print('${atmMarkers[item].atmName} #############################');
      setState(() {
        ListMarkers1.add(_ATMmarker);
      });
    }

//////////////Branch Marker
    for (var item = 0; item < branchMarkers.length; item++) {
      _BranchMarker = Marker(
          markerId: MarkerId('${branchMarkers[item].branchId}'),
          infoWindow: InfoWindow(title: '${branchMarkers[item].branchAddress}'),
          icon: branchbitmap,
          position: LatLng(lati_branch[item], longi_branch[item]));
      print(
          '${branchMarkers[item].branchAddress} %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
      setState(() {
        ListMarkers2.add(_BranchMarker);
      });
    }

    //////////////////
    print('####################################');

    print(ListMarkers1.length);
    myMarkers = ListMarkers1;
    print(ListMarkers2.length);

    print(
        'Method Enddddddddddddddd@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@###############################');
  }

  /////////////////////////////////////////////
  late GoogleMapController mapController;

  final LatLng _center = LatLng(31.897832390252894, 35.20152145891561);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GoogleMap(
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: true,
            zoomControlsEnabled: false,
            myLocationEnabled: false,
            onMapCreated: _onMapCreated,
            markers: myMarkers,
            // polylines: {
            //   const Polyline(
            //       width: 5,
            //       polylineId: PolylineId('polyLine'),
            //       color: Colors.black,
            //       startCap: Cap.squareCap,
            //       endCap: Cap.roundCap,
            //       points: [
            //         LatLng(31.711866242840067, 35.19599236432871),
            //         LatLng(31.842906720471834, 35.22999487850363)
            //       ])
            // },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
        ),
        Positioned(
            top: 8,
            right: 10,
            // right: 30,
            child: IconButton(
              onPressed: _showMarkers,
              icon: Icon(
                Icons.change_circle,
                size: 50,
              ),
              color: Color.fromARGB(255, 0, 137, 80),
            )),
        // Positioned(
        //     bottom: 50,
        //     left: 30,
        //     right: 30,
        //     child: Container(
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.all(Radius.circular(12)),
        //           color: Color.fromARGB(255, 19, 143, 23),
        //         ),
        //         child: ListTile(
        //           // tileColor: Color.fromARGB(255, 13, 134, 17),
        //           title: Text(
        //             'Al Maysoun',
        //             style: TextStyle(
        //                 color: Colors.white, fontWeight: FontWeight.bold),
        //           ),
        //           subtitle: Text(
        //             '100 KM, Nearest Branch',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ))),
      ],
    );
  }
}

class ATMs {
  final String atmId, atmName, atmBin;
  ATMs(this.atmId, this.atmName, this.atmBin);
}

class Branches {
  final String branchId, branchAddress, branchBin;
  Branches(this.branchId, this.branchAddress, this.branchBin);
}
