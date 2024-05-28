// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class Embassy { // Model class for embassy data (replace with your actual data structure)
//   final String name;
//   final double latitude;
//   final double longitude;

//   Embassy({required this.name, required this.latitude, required this.longitude});
// }

// class Airport { // Model class for airport data (replace with your actual data structure)
//   final String name;
//   final double latitude;
//   final double longitude;
//   final String? iataCode; // Optional: Include IATA code

//   Airport({required this.name, required this.latitude, required this.longitude, this.iataCode});
// }

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   final Set<Marker> _markers = {};
//   Location _location = Location();
//   late LatLng _userLocation;
//   bool _locationServiceEnabled = false;
//   PermissionStatus _permissionGranted;

//   Future<void> _getUserLocation() async {
//     _location = new Location();
//     _permissionGranted = await _location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _locationServiceEnabled = await _location.serviceEnabled();
//     if (!_locationServiceEnabled) {
//       _locationServiceEnabled = await _location.requestService();
//       if (!_locationServiceEnabled) {
//         return;
//       }
//     }

//     final locationData = await _location.getLocation();
//     _userLocation = LatLng(locationData.latitude!, locationData.longitude!);
//     setState(() {});
//   }

//   Future<void> _getEmbassies() async {
//     // Replace with your logic to fetch embassy data from an API or local source
//     // based on user location. Here's a placeholder example:
//     final embassies = [
//       Embassy(name: "Embassy of France", latitude: 48.856614, longitude: 2.352221),
//       Embassy(name: "Embassy of Japan", latitude: 51.509865, longitude: -0.128838),
//     ];
//     for (var embassy in embassies) {
//       final marker = Marker(
//         markerId: MarkerId(embassy.name),
//         position: LatLng(embassy.latitude, embassy.longitude),
//         icon: BitmapDescriptor.fromAsset('assets/icons/embassy.svg'), // Replace with your SVG asset
//       );
//       setState(() {
//         _markers.add(marker);
//       });
//     }
//   }

//   Future<void> _getAirports() async {
//     // Replace with your logic to fetch airport data from an API or local source
//     // based on user location. Here's a placeholder example:
//     final airports = [
//       Airport(name: "Heathrow Airport", latitude: 51.4706, longitude: -0.4597, iataCode: "LHR"),
//       Airport(name: "Charles de Gaulle Airport", latitude: 49.0114, longitude: 2.5578, iataCode: "CDG"),
//     ];
//     for (var airport in airports) {
//       final marker = Marker(
//         markerId: MarkerId(airport.name),
//         position: LatLng(airport.latitude, airport.longitude),
//         icon: BitmapDescriptor.fromAsset('assets/icons/airport.svg'), // Replace with your SVG asset
//       );
//       setState(() {
//         _markers.add(marker);
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Embassies & Airports'),
//       ),
//       body: Stack(
//         children: [
//           // Existing code for the map widget
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: _userLocation,
//               zoom: 14.0, // Adjust zoom level as needed
//             ),
//             markers: _markers,
//             myLocationEnabled: true,
//             zoomControlsEnabled: true,
//           ),

//           // Add buttons for filtering embassies and airports
//           Positioned(
//             bottom: 20.0,
//             left: 20.0,
//             child: FloatingActionButton(
//               onPressed: () async {
//                 await _getEmbassies();
//               },
//               child: SvgPicture.asset(
//                 'assets/icons/embassy.svg', // Replace with your SVG asset
//                 width: 24,
//                 height: 24,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 20.0,
//             right: 20.0,
//             child: FloatingActionButton(
//               onPressed: () async {
//                 await _getAirports();
//               },
//               child: SvgPicture.asset(
//                 'assets/icons/airport.svg', // Replace with your SVG asset
//                 width: 24,
//                 height: 24,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
