import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:label_marker/label_marker.dart';
import 'package:geolocator/geolocator.dart';

class Navigation extends StatefulWidget {
  // final Position p;
  // const Navigation({Key? key, required this.p}) : super(key: key);

  const Navigation({Key? key}) : super(key: key);

  // @override
  // State<Navigation> createState() => NavigationState(this.p);
  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  // final Position pos;

  // NavigationState(this.pos);

  // late BitmapDescriptor mapMarker;
  List<double> lati_ATM = [];
  List<double> longi_ATM = [];
  Set<Marker> myMarkers = {};
  List<LatLng> pointsList = [LatLng(32.226067078723155, 35.256443599712355)];

  @override
  void initState() {
    super.initState();
    // LatLng currentLocation = LatLng(this.pos.latitude, this.pos.longitude);
    // pointsList.add(currentLocation);
    print(
        'state@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@###############################');
    getATMsData();
    // setCustomeMarker();
  }

//////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
  getATMsData() async {
    print('=======================inside navigation classsssssss');
    Position place = await _determinePosition();
    pointsList.add(LatLng(place.latitude, place.longitude));
    print('nav-position---------------------------${place}');

    print(
        'Method startttttttt@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@###############################');
    BitmapDescriptor atmbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/atm-black.png");

    BitmapDescriptor branchbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(35, 40)), "assets/images/but.png");

    Marker sourceMarker = Marker(
        markerId: MarkerId('sou'),
        infoWindow: InfoWindow(title: 'source'),
        icon: branchbitmap,
        position: pointsList[0]);

    Marker distMarker = Marker(
        markerId: MarkerId('dis'),
        infoWindow: InfoWindow(title: 'distination'),
        icon: atmbitmap,
        position: pointsList[1]);

    setState(() {
      myMarkers.add(sourceMarker);
      myMarkers.add(distMarker);
    });
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
    return Scaffold(
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
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: GoogleMap(
                zoomControlsEnabled: false,
                myLocationEnabled: false,
                onMapCreated: _onMapCreated,
                markers: myMarkers,
                polylines: {
                  Polyline(
                      width: 5,
                      polylineId: PolylineId('polyLine'),
                      color: Colors.black,
                      endCap: Cap.roundCap,
                      points: pointsList)
                },
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
            Positioned(
                top: 70,
                left: 30,
                // right: 30,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.change_circle),
                  color: Color.fromARGB(255, 0, 137, 80),
                )),
            Positioned(
                bottom: 50,
                left: 30,
                right: 30,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Color.fromARGB(255, 0, 137, 80),
                    ),
                    child: ListTile(
                      // tileColor: Color.fromARGB(255, 13, 134, 17),
                      title: Text(
                        'Al Maysoun',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '100 KM, Nearest Branch',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Icon(
                        Icons.near_me,
                        color: Colors.white,

                        // size: 10,
                      ),
                    ))),
          ],
        ));
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
}

class ATMs {
  final String atmId, atmName, atmBin;
  ATMs(this.atmId, this.atmName, this.atmBin);
}

class Branches {
  final String branchId, branchAddress, branchBin;
  Branches(this.branchId, this.branchAddress, this.branchBin);
}
