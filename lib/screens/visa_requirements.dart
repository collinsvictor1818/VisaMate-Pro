import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:http/http.dart' as http;

import '../component/appbars/CustomAppBar.dart';
import '../component/form/CustomButton.dart';
import '../component/country_picker.dart';

// Define the VisaInfoPage class...
class VisaInfoPage extends StatefulWidget {
  @override
  _VisaInfoPageState createState() => _VisaInfoPageState();
}

class _VisaInfoPageState extends State<VisaInfoPage> {
  String _originCountryCode = "KE";
  String _destinationCountryCode = "TZ";
  VisaInfo? _visaInfo;
  bool _isLoading = false;
  String _errorMessage = "";

  String convertToISO2CountryCode(String alpha2Code) {
    List<String> parts = alpha2Code.split(' ');
    String countryCode = parts.first;
    int firstCodeUnit = countryCode.runes.elementAt(0);
    int secondCodeUnit = countryCode.runes.elementAt(1);

    String iso2CountryCode = String.fromCharCode(firstCodeUnit - 0x1F1E6 + 0x41) +
        String.fromCharCode(secondCodeUnit - 0x1F1E6 + 0x41);
    
    return iso2CountryCode;
  }

  Future<void> _fetchVisaInfo() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    String origin = convertToISO2CountryCode(_originCountryCode);
    String destination = convertToISO2CountryCode(_destinationCountryCode);

    if (origin == destination) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Origin and destination countries cannot be the same.";
      });
      return;
    }

    try {
      final url = Uri.parse("https://rough-sun-2523.fly.dev/api/$origin/$destination");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('error') && jsonData['error']['status'] == true) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Server error: ${jsonData['error']['error']}';
          });
          return;
        }

        if (jsonData.containsKey('passport') && jsonData.containsKey('destination')) {
          setState(() {
            _visaInfo = VisaInfo.fromJson(jsonData);
          });
        } else {
          setState(() {
            _errorMessage = 'Invalid response format';
          });
        }
      } else {
        setState(() {
          _errorMessage = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Error fetching data: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Visa Requirements'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CountryPicker(
                          text: 'Origin',
                          desc: 'Country of residency',
                          onCountryChange: (value) => setState(() {
                            _originCountryCode = value;
                          }),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CountryPicker(
                          text: 'Destination',
                          desc: 'Desired destination',
                          onCountryChange: (value) => setState(() {
                            _destinationCountryCode = value;
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
                FormButton(
                  action: _fetchVisaInfo,
                  text: 'Fetch Visa Info',
                ),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      )
                    : _errorMessage.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(child: Text(_errorMessage)))
                        : _visaInfo != null
                            ? Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                            
                                      children: [
                                        Text(_originCountryCode),
                                        Icon(Icons.arrow_circle_right_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary),
                                        Text(_destinationCountryCode),
                                      ],
                                    ),
                                    Text(
                                      'Visa Status: ${_visaInfo!.status}',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    if (_visaInfo!.category != null)
                                      Text('Category: ${_visaInfo!.category}'),
                                    if (_visaInfo!.dur != null)
                                      Text('Duration: ${_visaInfo!.dur} days'),
                                    Text(
                                      'Last Updated: ${_visaInfo!.lastUpdated}',
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                    child: Text('No visa information found')),
                              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VisaInfo {
  final String passport;
  final String destination;
  final String? dur;
  final String status;
  final String category;
  final DateTime lastUpdated;

  VisaInfo({
    required this.passport,
    required this.destination,
    required this.status,
    required this.category,
    required this.lastUpdated,
    this.dur,
  });

  factory VisaInfo.fromJson(Map<String, dynamic> json) {
    return VisaInfo(
      passport: json['passport'],
      destination: json['destination'],
      dur: json['dur'],
      status: json['status'],
      category: json['category'],
      lastUpdated: DateTime.parse(json['last_updated']),
    );
  }
}

