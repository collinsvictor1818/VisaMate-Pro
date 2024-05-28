import 'package:flutter/material.dart';
import '../../../models/requirements_model.dart';

class VisaRequirementsPage extends StatefulWidget {
  @override
  _VisaRequirementsPageState createState() => _VisaRequirementsPageState();
}

class _VisaRequirementsPageState extends State<VisaRequirementsPage> {
  late Future<List<VisaRequirement>> _visaRequirementsFuture;
  List<VisaRequirement> _visaRequirements = [];
  String? _selectedFromCountry;
  String? _selectedToCountry;
  String? _visaRequirement;

  @override
  void initState() {
    super.initState();
    _visaRequirementsFuture = loadVisaRequirements();
    _visaRequirementsFuture.then((data) {
      setState(() {
        _visaRequirements = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visa Requirements')),
      body: FutureBuilder<List<VisaRequirement>>(
        future: _visaRequirementsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final countries = _visaRequirements
                .map((visa) => visa.fromCountry)
                .toSet()
                .toList();
            countries.sort();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButton<String>(
                    value: _selectedFromCountry,
                    hint: Text('Select Origin Country'),
                    isExpanded: true,
                    items: countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFromCountry = value;
                        _visaRequirement = null;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButton<String>(
                    value: _selectedToCountry,
                    hint: Text('Select Destination Country'),
                    isExpanded: true,
                    items: countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedToCountry = value;
                        _visaRequirement = null;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _selectedFromCountry != null &&
                            _selectedToCountry != null
                        ? _fetchVisaRequirement
                        : null,
                    child: Text('Get Visa Requirement'),
                  ),
                  SizedBox(height: 16),
                  if (_visaRequirement != null)
                    Text(
                      'Visa Requirement from $_selectedFromCountry to $_selectedToCountry: $_visaRequirement',
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _fetchVisaRequirement() {
    final requirement = _visaRequirements.firstWhere(
      (visa) =>
          visa.fromCountry == _selectedFromCountry &&
          visa.toCountry == _selectedToCountry,
      orElse: () => VisaRequirement(
        fromCountry: _selectedFromCountry!,
        toCountry: _selectedToCountry!,
        visaRequirement: 'No data available',
      ),
    );
    setState(() {
      _visaRequirement = requirement.visaRequirement;
    });
  }
}
