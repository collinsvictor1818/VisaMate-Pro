import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class CountryMap extends StatelessWidget {  
  Completer<GoogleMapController> _controller = Completer();

  final String name;
  final List latlang;

  CountryMap(this.name, this.latlang);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(this.name),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(this.latlang[0], this.latlang[1]),
          zoom: 5,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}