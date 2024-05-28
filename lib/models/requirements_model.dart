import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

          
class VisaRequirement {
  final String fromCountry;
  final String toCountry;
  final String visaRequirement;

  VisaRequirement({
    required this.fromCountry,
    required this.toCountry,
    required this.visaRequirement,
  });

  factory VisaRequirement.fromCsv(List<dynamic> row) {
    return VisaRequirement(
      fromCountry: row[0] as String,
      toCountry: row[1] as String,
      visaRequirement: row[2] as String,
    );
  }
}

Future<List<VisaRequirement>> loadVisaRequirements() async {
  final csvData = await rootBundle.loadString('assets/visa_requirements.csv');
  List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

  // Convert rows to VisaRequirement objects
  List<VisaRequirement> visaRequirements = rows.map((row) {
    return VisaRequirement.fromCsv(row);
  }).toList();

  return visaRequirements;
}
