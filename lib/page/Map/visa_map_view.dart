import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visamate/styles/theme/light_theme.dart';

/// This widget is the home page of the application.
class VisaMap extends StatefulWidget {
  /// Initialize the instance of the [VisaMap] class.
  const VisaMap({Key? key}) : super(key: key);

  @override
  State<VisaMap> createState() => _VisaMapState();
}

class _VisaMapState extends State<VisaMap> {
  late List<CountryModel> _data;
  late MapShapeSource _mapSource;
  late MapZoomPanBehavior _zoomPanBehavior;
  Position? _currentPosition;

  final _geolocator = GeolocatorPlatform.instance;
  final _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _loadData(); // Call a separate method to load data and initialize variables
  }

  Future<void> _loadData() async {
    // Load data from network or local storage
    _data = <CountryModel>[
      CountryModel('Afghanistan', Color.fromRGBO(255, 78, 66, 1.0), 'AFG'),
      CountryModel('India', Color.fromRGBO(66, 165, 245, 1.0), 'IND'),
      CountryModel('United States', Color.fromRGBO(76, 175, 80, 1.0), 'USA'),
      // Add more countries as needed
    ];

    // Assuming the JSON response structure (modify based on your actual data)
    // final response = await // Your network call or local file read;
    // _data = (response as List).map((e) => CountryModel.fromJson(e)).toList();

    // _mapSource = MapShapeSource.network(
    //   'http://www.json-generator.com/api/json/get/bVqXoJvfjC?indent=2',
    //   shapeDataField: 'name',
    //   dataCount: _data.length,
    //   primaryValueMapper: (int index) => _data[index].name,
    //   dataLabelMapper: (int index) => _data[index].abbr,
    //   shapeColorValueMapper: (int index) => _data[index].color,
    // );

    _mapSource = MapShapeSource.asset(
      'assets/json/countries.geo.json',
      shapeDataField: 'name',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].name,
      dataLabelMapper: (int index) => _data[index].abbr,
      shapeColorValueMapper: (int index) => _data[index].color,
    );

    _zoomPanBehavior = MapZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      zoomLevel: 3,
      maxZoomLevel: 10,
      minZoomLevel: 1,
      focalLatLng:
          const MapLatLng(20.5937, 78.9629), // Initial center of the map
    );
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
        _zoomPanBehavior.focalLatLng = MapLatLng(latitude, longitude);
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await _geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        _zoomPanBehavior.focalLatLng =
            MapLatLng(position.latitude, position.longitude);
        _saveLocationToPrefs(_currentPosition!);
      });
    } catch (e) {
      // Handle location error
      print(e);
    }
  }

  Future<void> _startLocationUpdates() async {
    _geolocator.getPositionStream().listen((position) {
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
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        // Handle restricted/limited/permanentlyDenied case
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
        backgroundColor: Colors.blue.shade100,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                height: constraints.maxHeight * 1,
                child: SfMaps(
                  layers: <MapShapeLayer>[
                    MapShapeLayer(
                      source: _mapSource,
                      showDataLabels: true,
                      // legend: MapLegend(
                      //   MapElement.shape,
                      //   position: MapLegendPosition.bottom,
                      //   // labelsPlacement: MapLegendLabelsPlacement.betweenItems,
                      // ),
                      // legend: MapLegend(MapElement.bubble,),
                      tooltipSettings: MapTooltipSettings(
                        color: Theme.of(context).colorScheme.tertiary,
                        strokeColor: Colors.white,
                        strokeWidth: 2,
                      ),
                      // markerTooltipBuilder: MarkerTooltipBuilder(),
                      strokeColor: Colors.white,
                      strokeWidth: 0.5,
                      shapeTooltipBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _data[index].name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                      loadingBuilder: (BuildContext context) {
                        return Center(
                          // height: 55,
                          // width: 25,
                          child: Column(
                            children: [
                              CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                              Text(
                                'Map is loading....',
                              ),
                            ],
                          ),
                        );
                      },
                      dataLabelSettings: MapDataLabelSettings(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Theme.of(context).textTheme.bodySmall?.fontSize ??
                                  12.0,
                        ),
                      ),
                      zoomPanBehavior: _zoomPanBehavior,
                      onSelectionChanged: (int index) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(_data[index].name),
                              content: Text(
                                  'Country: ${_data[index].name}\nAbbreviation: ${_data[index].abbr}'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      sublayers: [
                        MapShapeSublayer(
                          source: _mapSource,
                          showDataLabels: true,
                          dataLabelSettings: const MapDataLabelSettings(
                            overflowMode: MapLabelOverflow.ellipsis,
                            textStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Gilmer'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CountryModel {
  /// Initialize the instance of the [CountryModel] class.
  const CountryModel(this.name, this.color, this.abbr);

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        json['name'] as String,
        Color(json['color'] as int),
        json['abbr'] as String,
      );

  /// Represents the country name.
  final String name;

  /// Represents the country color.
  final Color color;

  /// Represents the country abbreviation.
  final String abbr;
}
