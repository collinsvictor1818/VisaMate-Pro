import 'dart:convert';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'dart:io';

class VisaMap extends StatefulWidget {
  @override
  _VisaMapState createState() => _VisaMapState();
}

class _VisaMapState extends State<VisaMap> {
  Map<String, dynamic> geoJsonData = {}; // Initialize or use 'late'
  Map<String, String> visaRequirements = {};

  @override
  void initState() {
    super.initState();
    loadGeoJsonData();
    loadVisaRequirements();
  }

  Future<void> loadGeoJsonData() async {
    String data = await rootBundle.loadString('assets/countries.geo.json');
    setState(() {
      geoJsonData = json.decode(data);
    });
  }

  Future<void> loadVisaRequirements() async {
    var file = "assets/visa_requirements.xlsx"; // Path to your Excel file
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      if (excel.tables[table] != null) {
        for (var row in excel.tables[table]!.rows.skip(1)) {
          String countryCode = row[0]?.toString() ?? '';
          String visaType = row[1]?.toString() ?? '';
          visaRequirements[countryCode] = visaType;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (geoJsonData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Visa Requirements Map'),
      ),
      body: SfMaps(
        layers: [
          MapShapeLayer(
            source: MapShapeSource.asset(
              'assets/countries.geo.json',
              shapeDataField: 'id',
              dataCount: visaRequirements.length,
              primaryValueMapper: (int index) => visaRequirements.keys.elementAt(index),
              shapeColorValueMapper: (int index) {
                String visaType = visaRequirements.values.elementAt(index);
                switch (visaType) {
                  case 'Visa required':
                    return Colors.red;
                  case 'Visa not required':
                    return Colors.green;
                  case 'Visa on arrival':
                    return Colors.orange;
                  default:
                    return Colors.grey;
                }
              },
            ),
            showDataLabels: true,
            dataLabelSettings: MapDataLabelSettings(
              textStyle: TextStyle(color: Colors.black, fontSize: 8),
            ),
            strokeColor: Colors.white,
            strokeWidth: 0.5,
            onSelectionChanged: (int index) {
              String countryCode = visaRequirements.keys.elementAt(index);
              String visaInfo = visaRequirements[countryCode]!;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(countryCode),
                    content: Text('Visa requirements: $visaInfo'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
