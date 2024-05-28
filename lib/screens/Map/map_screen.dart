import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visamate/component/appbars/BottomNav.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import '../../component/appbars/CustomBottomNavBar.dart';
import '../../component/cards/action_chip.dart';
import '../../component/cards/updates&events.dart';
import '../../styles/pallete.dart';
import '../../styles/theme/light_theme.dart';

class MapScreen extends StatefulWidget {
  const MapScreen();

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _searchController = TextEditingController();
  Position? _currentPosition;
   final _mapController = MapController();
  final _geolocator = GeolocatorPlatform.instance;
  final _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _loadLocationFromPrefs();
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

  Future<void> _requestLocationPermission() async {
    final locationStatus = await Permission.locationWhenInUse.request();
    if (locationStatus == PermissionStatus.granted) {
      _getCurrentLocation();
      _startLocationUpdates();
    }
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
        // Handle limited case (Android   0+ background location)
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme, 
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(centerTitle: true,elevation: 0, leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onTertiary,),onPressed: (){},),title: Text('Find Visa', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontFamily: "Gilmer", fontSize: 25, fontWeight: FontWeight.w700),),backgroundColor: Colors.transparent,foregroundColor: Colors.transparent,),
      
        body: Stack(
          children: [
            _currentPosition != null
                ? FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude),
                      initialZoom: 11,
                      // enableScrollWheel: true,
                      backgroundColor: AppColor.white,
                      // enableMultiFingerGestureRace: true,
                      interactionOptions: const InteractionOptions(
                          flags: ~InteractiveFlag.doubleTapZoom),
                    ),
                    children: [
                      openStreetMapTileLayer,
                      MarkerLayer(
                        rotate: false,
                        alignment: Alignment.center,
                        markers: [
                          Marker(
                            point: LatLng(_currentPosition!.latitude,
                                _currentPosition!.longitude),
                            width: 60,
                            height: 60,
                            child: Icon(Icons.location_pin,
                                size: 40,
                                color: Theme.of(context).colorScheme.tertiary),
                          ),
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
            Positioned(
                top: 30.0,
                left: 10.0,
                right: 10.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.09),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    // Spacer(flex:1),
                  ],
                )),
                    
            Positioned(
              top: 75.0,
              left: 10.0,
              right: 10.0,
              child: TextFormField(
                style: TextStyle(
                  fontFamily: 'Gilmer',
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.w700,
                ),
                // inputFormatters: ,
                enableSuggestions: true,
                keyboardType: TextInputType.text,
                controller: _searchController,
                // validator: widget.validator,
                // onChanged: widget.onChanged,
                cursorColor: Theme.of(context).colorScheme.tertiary,
                decoration: InputDecoration(
                  focusColor: Theme.of(context).colorScheme.tertiary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.05),
                      width: 2,
                    )),
                  prefixIcon: Icon(Icons.location_pin,
                      color: Theme.of(context).colorScheme.tertiary, size: 16),
                  suffixIcon: Icon(Icons.search,
                      color: Theme.of(context).colorScheme.tertiary, size: 16),
                  fillColor: AppColor.accentLight,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary, width: 0),
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: "Gilmer",
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).hintColor),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColor.accentLight,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 135.0,
              left: 10.0,
              right: 10.0,
              child: Container(
                height: 40,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const SizedBox(
                        width: 105,
                        child: ChipCard(title: 'Embassies'),
                      );
                    } else if (index == 1) {
                      return const SizedBox(
                        width: 105,
                        child: ChipCard(title: 'Airports'),
                      );
                    } else if (index == 2) {
                      return const SizedBox(
                        width: 105,
                        child: ChipCard(),
                      );
                    } 
                    else if (index == 3) {
                      return const SizedBox(
                        width: 105,
                        child: ChipCard(),
                      );
                    } else {
                      return const SizedBox(
                        width: 105,
                        child: ChipCard(),
                      );
                    }
                    
                  },
                ),
              ),
            ),
          ],
        ),
        // ignore: prefer_const_constructors
        // bottomNavigationBar: CustomAnimatedBottomBar(items: [BottomNavyBarItem(icon: Icon(Icons.abc), title: 'A B C', )],),
      ),
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
