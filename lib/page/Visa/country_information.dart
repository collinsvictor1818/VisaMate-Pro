import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:http/http.dart' as http;

import '../../component/appbars/CustomAppBar.dart';
import '../../component/country_picker.dart';
import '../../component/form/CustomButton.dart';

const apiKey = 'X6bv8Isr0Ei0Ikt0ZRsYWA==4EqFxM10XndIn80a';
const baseUrl = 'https://api.api-ninjas.com/v1/country';

class CountryInfo extends StatefulWidget {
  @override
  _CountryInfoState createState() => _CountryInfoState();
}

class _CountryInfoState extends State<CountryInfo> {
  String _countryInfo = '';
  bool _isLoading = false;
  String _countryName = "KE";
  CountryInfoModel? _country;
  String _errorMessage = "";

  Future<void> _fetchCountryInfo(String countryName) async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    final url = Uri.parse('$baseUrl?name=$countryName');
    final headers = {'X-Api-Key': apiKey};

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData.isNotEmpty) {
          setState(() {
            _country = CountryInfoModel.fromJson(jsonData[0]);
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'No data found';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = "Error: ${response.statusCode} - ${response.body}";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Error fetching data: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Country Info'),
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
                          text: 'Country',
                          desc: 'Country of residency',
                          onCountryChange: (value) => setState(() {
                            _countryName = value;
                            List<String> parts = _countryName.split(' ');
                            String countryNameFull = parts.last;
                            _countryName = countryNameFull;
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
                FormButton(
                  action: () async {
                    await _fetchCountryInfo(_countryName);
                  },
                  text: 'Fetch Country Info',
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
                        : _country != null
                            ? Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Country: ${_country!.name}'),
                                      ],
                                    ),
                                    Text('Country Code: ${_country!.iso2}'),
                                    Text('Population: ${_country!.population}'),
                                    // Add more fields as necessary
                                  ],
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(child: Text('No country information found')),
                              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CountryInfoModel {
  final String name;
  final String iso2;
  final double population;
  final double pop_growth;
  final double pop_density;
  final double surface_area;
  final double gdp;
  final double gdp_growth;
  final double gdp_per_capita;
  final double life_expectancy_male;
  final double life_expectancy_female;
  final double infant_mortality;
  final double fertility;
  final double unemployment;
  final double imports;
  final double exports;
  final double co2_emissions;
  final double forested_area;
  final double tourists;
  final double threatened_species;
  final double urban_population;
  final double urban_population_growth;

  CountryInfoModel({
    required this.name,
    required this.iso2,
    required this.population,
    required this.pop_growth,
    required this.pop_density,
    required this.surface_area,
    required this.gdp,
    required this.gdp_growth,
    required this.gdp_per_capita,
    required this.life_expectancy_male,
    required this.life_expectancy_female,
    required this.infant_mortality,
    required this.fertility,
    required this.unemployment,
    required this.imports,
    required this.exports,
    required this.co2_emissions,
    required this.forested_area,
    required this.tourists,
    required this.threatened_species,
    required this.urban_population,
    required this.urban_population_growth,
  });

  factory CountryInfoModel.fromJson(Map<String, dynamic> json) {
    return CountryInfoModel(
      name: json['name'],
      iso2: json['iso2'],
      population: (json['population'] as num).toDouble(),
      pop_growth: (json['pop_growth'] as num).toDouble(),
      pop_density: (json['pop_density'] as num).toDouble(),
      surface_area: (json['surface_area'] as num).toDouble(),
      gdp: (json['gdp'] as num).toDouble(),
      gdp_growth: (json['gdp_growth'] as num).toDouble(),
      gdp_per_capita: (json['gdp_per_capita'] as num).toDouble(),
      life_expectancy_male: (json['life_expectancy_male'] as num).toDouble(),
      life_expectancy_female: (json['life_expectancy_female'] as num).toDouble(),
      infant_mortality: (json['infant_mortality'] as num).toDouble(),
      fertility: (json['fertility'] as num).toDouble(),
      unemployment: (json['unemployment'] as num).toDouble(),
      imports: (json['imports'] as num).toDouble(),
      exports: (json['exports'] as num).toDouble(),
      co2_emissions: (json['co2_emissions'] as num).toDouble(),
      forested_area: (json['forested_area'] as num).toDouble(),
      tourists: (json['tourists'] as num).toDouble(),
      threatened_species: (json['threatened_species'] as num).toDouble(),
      urban_population: (json['urban_population'] as num).toDouble(),
      urban_population_growth: (json['urban_population_growth'] as num).toDouble(),
    );
  }
}
