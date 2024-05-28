import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryPicker extends StatefulWidget {
  final String text;
  final TextEditingController? controller;
  final String? hint;
  final Function(String)? onCountryChange;
  final String? desc;
  final IconData? prefix;
  final VoidCallback? onClicked;
  final bool? city;
  final bool? state;

  const CountryPicker({
    required this.text,
    this.controller,
    this.hint,
    this.onCountryChange,
    this.city,
    this.state,
    this.desc,
    this.prefix,
    this.onClicked,
  });

  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  // CscCountry? _selectedCountry;

  @override
  void initState() {
    super.initState();
    // _setDefaultCountry();
  }

  //   Future<void> _setDefaultCountry() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // Check if the country is already saved in SharedPreferences
  //   if (!prefs.containsKey('defaultCountry')) {
  //     // Fetch user's location and extract country
  //     String country = await _fetchUserCountry();
  //     // Save country in SharedPreferences
  //     await prefs.setString('defaultCountry', country);
  //     setState(() {
  //       _selectedCountry = _mapStringToCscCountry(country);
  //     });
  //   } else {
  //     // Retrieve saved country from SharedPreferences
  //     String? savedCountry = prefs.getString('defaultCountry');
  //     setState(() {
  //       _selectedCountry = _mapStringToCscCountry(savedCountry!);
  //     });
  //   }
  // }

  // Future<String> _fetchUserCountry() async {
  //   // Implement logic to fetch user's location and extract country
  //   // For example, you can use the geolocator package
  //   // Here's a simplified example:
  //   // String country = await Geolocator().getCurrentPosition().then((position) {
  //   //   // Use position data to determine country
  //   //   return 'United States'; // Example country
  //   // });
  //   return 'United States'; // Example country
  // }


  // CscCountry? _mapStringToCscCountry(String country) {
  //   switch (country) {
  //     case 'United States':
  //       return CscCountry.United_States;
  //     // Add mappings for other countries as needed
  //     default:
  //       return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.text,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w700,
            fontFamily: 'Gilmer',
            fontSize: 18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            widget.desc ?? '',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilmer',
              fontSize: 12,
            ),
          ),
        ),
        CSCPicker(
          dropdownHeadingStyle: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w700,
            fontFamily: 'Gilmer',
            fontSize: 14,
          ),
          showStates: widget.state?? false,
          dropdownItemStyle: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w700,
            fontFamily: 'Gilmer',
            fontSize: 14,
          ),
          flagState: CountryFlag.ENABLE,
          showCities: widget.city ?? false,
          searchBarRadius: 5,
          defaultCountry: CscCountry.United_Kingdom,
          dropdownDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(5),
          ),
          disabledDropdownDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(5),
          ),
          // onCountryChanged: (value) {
          //   setState(() {
          //     // countryValue = value;
          //   });
          // },
          onCountryChanged: widget.onCountryChange,
          onStateChanged: (value) {
            setState(() {
              // stateValue=value;
            });
          },
          onCityChanged: (value) {
            setState(() {
              // cityValue=value;
            });
          },
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 7)),
      ],
    );
  }
}
