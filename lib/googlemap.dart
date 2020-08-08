import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewMap extends StatefulWidget {
  @override
  _ViewMapState createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Circle> _circles = HashSet<Circle>();
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _setPolygon();
  }
  
  void _setPolygon() {
    _polygons.add(Polygon(
      polygonId: PolygonId("myPolygon"),
      points: const <LatLng>[
        LatLng(24.2049, 82.7832),
        //LatLng(24.2182, 83.0346),
        LatLng(24.1992, 82.6645),
        LatLng(24.6850, 83.0684),
      ],
      strokeWidth: 2,
      strokeColor: Colors.red,
      fillColor: Colors.red.withOpacity(0.20)
      )
    );
  }
  void _setCircle(){
    _circles.add(Circle(
        circleId: CircleId("myCircle"),
        center: LatLng(latitude,longitude),
        radius: 500,
        fillColor: Colors.amber.withOpacity(0.5),
        strokeWidth: 3,
        strokeColor: Colors.amber
    ));
  }
  double latitude;
  double longitude;


   void _getCurrentLocation() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(24.2049, 82.7832),
            zoom: 10
          ),
          mapType: MapType.normal,
          circles: _circles,
          polygons: _polygons,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            child: Icon(Icons.add_circle),
            onPressed:() {
              _setCircle();
              _getCurrentLocation();
             }
          ),
        ),
      ),
    );
  }
}
