import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PromptLocation extends StatefulWidget {
  const PromptLocation();

  @override
  State<PromptLocation> createState() => _PromptLocationState();
}

class _PromptLocationState extends State<PromptLocation> {
  Position? _currentPosition;

  final _geolocator = GeolocatorPlatform.instance;
  final _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _loadLocationFromPrefs();
  }

  Future<void> _checkLocationPermission() async {
    final locationStatus = await Permission.locationWhenInUse.status;
    switch (locationStatus) {
      case PermissionStatus.granted:
        _getCurrentLocation();
        _startLocationUpdates();
        break;
      case PermissionStatus.denied:
        _requestLocationPermission();
        break;
      case PermissionStatus.restricted:
        // Handle restricted case (e.g., open app settings)
        break;
      case PermissionStatus.limited:
        // Handle limited case (Android 10+ background location)
        break;
      default:
        break;
    }
  }

  Future<void> _requestLocationPermission() async {
    final locationStatus = await Permission.locationWhenInUse.request();
    if (locationStatus == PermissionStatus.granted) {
      _getCurrentLocation();
      _startLocationUpdates();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await _geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        _saveLocationToPrefs(_currentPosition!);
      });
    } catch (e) {
      // Handle location error
      print(e);
    }
  }

  Future<void> _startLocationUpdates() async {
    _geolocator
        .getPositionStream() // Removed unnecessary arguments for interval and distance
        .listen((position) {
      setState(() {
        _currentPosition = position;
        _saveLocationToPrefs(_currentPosition!);
      });
    });
  }

  Future<void> _saveLocationToPrefs(Position position) async {
    final prefs = await _prefs;
    prefs.setDouble('latitude', position.latitude);
    prefs.setDouble('longitude', position.longitude);
  }

  Future<void> _loadLocationFromPrefs() async {
    final prefs = await _prefs;
    final double? latitude = prefs.getDouble('latitude');
    final double? longitude = prefs.getDouble('longitude');
    if (latitude != null && longitude != null) {
      setState(() {
        _currentPosition = Position(
          latitude: latitude,
          longitude: longitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
      });
    } else {
      // If no location is loaded, set a default position
      setState(() {
        _currentPosition = Position(
          latitude: 0.0,
          longitude: 0.0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
        print("Current Position set: $_currentPosition");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _currentPosition != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Latitude: ${_currentPosition?.latitude}'?? '',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Longitude: ${_currentPosition?.longitude}' ?? '',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
      ),
    );
  }
}
