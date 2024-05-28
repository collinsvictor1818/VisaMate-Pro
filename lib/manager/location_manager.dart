import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:visamate/component/bottom_menu.dart';

Future<Position> _determinePosition() async {
  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled return an error message
    return Future.error('Location services are disabled.');
  }

  // Check location permissions
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  }

  // If permissions are granted, return the current location
  return await Geolocator.getCurrentPosition();
}
///
///
///
///
///
///
///
///
///   Get location updates
///
///
void getLocationUpdates() {
  final locationSettings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);
  StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
    (Position position) {
        print(position == null ? 'Unknown' : '${position.latitude}, ${position.longitude}');
    }
  );
}

///
///
///
///
///
///
///   Check if location services are enabled
///
///
void checkIfLocationServiceIsEnabled() async {
  bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
  if (isLocationServiceEnabled) {
    // You can fetch location data here or alert the user that location services are turned on.
    print('Location services are enabled');
  } else {
    // You could try to prompt the user to turn on location services here or handle it differently.
    print('Location services are disabled');
                                    
  }
}
///
///
///
///
///
///
///
/// Checking Permision
///
///
///
void checkLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // Permissions are denied.
    print("Location permissions are denied");
  } else if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever.
    print("Location permissions are permanently denied");
  } else {
    // Permissions are granted (either can be whileInUse, always, restricted).
    print("Location permissions are granted");
  }
}
///
///
///
///
///
///
///
///
///   Request for permission
/// 
///  
/// 
void requestLocationPermission() async {
  LocationPermission permission =   await Geolocator.checkPermission();
  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    // Permissions are denied or denied forever, let's request it!
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("Location permissions are still denied");
    } else if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied");
    } else {
      // Permissions are granted (either can be whileInUse, always, restricted).
      print("Location permissions are granted after requesting");
    }
  }
}
///
///
///
///
/// 
///
///   Calculate Location Distance
/// 
/// 
/// 
void calculateDistance() {
  double startLatitude = 52.2165157;
  double startLongitude = 6.9437819;
  double endLatitude = 52.3546274;
  double endLongitude = 4.8285838;

  double distanceInMeters = Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);

  print('The distance between these points is $distanceInMeters meters.');
}