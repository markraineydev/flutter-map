import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_test/model/map_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.0625,-95.677068),
    zoom: 4,
  );


  late double width, height;

  Completer<GoogleMapController> _controller = Completer();

  
  @override
  void initState() {
    list.add(MapModel(name: "South Dakota", address: "South Dakota Address", latitude: 44.1946837, longitude: -102.4906533));
    list.add(MapModel(name: "Rapid City", address: "Rapid City South Dakota", latitude: 44.0695689, longitude: -103.2526202));
    list.add(MapModel(name: "Black Hills National Forest", address: "Rocks, canyons & grasslands with campgrounds, picnic sites, scenic roads & 350+ miles of trails.", latitude: 44.0140523, longitude: -104.4310106));
    list.add(MapModel(name: "Moorcroft", address: "Moorcroft is a town in Crook County, Wyoming, United States. The population was 946 at the 2020 census.", latitude: 44.2705031, longitude: -104.941021));

    _add();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(

        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }

  List<MapModel> list = [];

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _add() {
    for(int i = 0 ; i < list.length ; i++){

      var model = list[i];

      var markerIdVal = model.name;
      final MarkerId markerId = MarkerId(markerIdVal);
      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          model.latitude,
          model.longitude,
        ),
        infoWindow: InfoWindow(title: markerIdVal, snippet: model.address),
        onTap: () {

          // _onMarkerTapped(markerId);
        },
      );
      markers[markerId] = marker;
    }
    setState(() {
    });
  }
}
