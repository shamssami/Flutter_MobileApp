import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:label_marker/label_marker.dart';
import 'package:geolocator/geolocator.dart';

class Navigation extends StatefulWidget {
  final String name;
  final double binLat;
  final double binLon;

  final double distance;

  const Navigation(
      {Key? key,
      required this.name,
      required this.binLat,
      required this.binLon,
      required this.distance})
      : super(key: key);

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  List<double> lati_ATM = [];
  List<double> longi_ATM = [];
  Set<Marker> myMarkers = {};
  List<LatLng> pointsList = [];
  LatLng _center = LatLng(31.7054, 35.2024);
  @override
  void initState() {
    super.initState();
    pointsList.add(LatLng(widget.binLat, widget.binLon));
    print(
        'state@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@###############################');
    getATMsData();
  }

  getATMsData() async {
    // List<LatLng> pointsList = [LatLng(widget.binLat, widget.binLon)];

    print('=======================inside navigation classsssssss');
    Position place = await _determinePosition();

    LatLng currentLocation = LatLng(place.latitude, place.longitude);
    pointsList.add(currentLocation);
    setState(() {
      _center = currentLocation;
    });
    print('nav-position---------------------------${place}');

    print(
        'Method startttttttt@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@###############################');
    BitmapDescriptor atmbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/atm-black.png");

    BitmapDescriptor branchbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(35, 40)), "assets/images/but.png");

    Marker sourceMarker = Marker(
        markerId: MarkerId('Location'),
        infoWindow: InfoWindow(title: 'Source'),
        icon: branchbitmap,
        position: pointsList[1]);

    Marker distMarker = Marker(
        markerId: MarkerId('distination'),
        infoWindow: InfoWindow(title: '${widget.name}'),
        icon: atmbitmap,
        position: pointsList[0]);

    setState(() {
      myMarkers.add(distMarker);

      myMarkers.add(sourceMarker);
    });
  }

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final String x = widget.name;
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
                  Navigator.pop(context);
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
                      jointType: JointType.round,
                      width: 4,
                      polylineId: PolylineId('polyLine'),
                      color: Colors.black,
                      points: pointsList)
                },
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
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
                        '${widget.name}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${widget.distance} KM away',
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
