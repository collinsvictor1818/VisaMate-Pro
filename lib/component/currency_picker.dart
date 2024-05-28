import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:country_currency_pickers/currency_picker_dropdown.dart';
import 'package:country_currency_pickers/currency_picker_dialog.dart';
import 'package:country_currency_pickers/currency_picker_dropdown.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/currency_picker_cupertino.dart';
import 'package:country_currency_pickers/currency_picker_dialog.dart';
import 'package:country_currency_pickers/currency_picker_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_currency_pickers/country_pickers.dart';

class CurrencyPicker extends StatefulWidget {
  final String text;
  final TextEditingController? controller;
  final String? hint;
  final String? desc;
  final IconData? prefix;
  final VoidCallback? onClicked;

  const CurrencyPicker({
    required this.text,
    this.controller,
    this.hint,
    this.desc,
    this.prefix,
    this.onClicked,
  });

  @override
  _CurrencyPickerState createState() => _CurrencyPickerState();
}

class _CurrencyPickerState extends State<CurrencyPicker> {
  CscCountry? _selectedCountry;
  Country _selectedDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('90');
  Widget _buildCurrencyDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("(${country.currencyCode})"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name ?? ''))
        ],
      );

  @override
  void initState() {
    super.initState();
    // _setDefaultCountry();
  }
void _openCurrencyPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CurrencyPickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text('Select your Currency'),
                onValuePicked: (Country country) =>
                    setState(() => _selectedDialogCountry = country),
                itemBuilder: _buildCurrencyDialogItem)),
      );

  Widget _buildCurrencyDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            // CountryPickerUtils.getDefaultFlagImage(country),
            Icon(Icons.euro_symbol_rounded,
                    color: Theme.of(context).colorScheme.tertiary),
            SizedBox(
              width: 8.0,
            ),
            Text("${country.currencyCode}", style: TextStyle(
                fontFamily: 'Gilmer',
                fontSize: 14,
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.w700,
              ),),
          ],
        ),
      );

  // final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter();
                  // _buildCurrencyDialogItem(_selectedDialogCurrency),

  _buildCurrencyPickerDropdown(bool filtered) => Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: CurrencyPickerDropdown(
                initialValue: 'EUR',
                itemBuilder: _buildCurrencyDropdownItem,
                itemFilter: filtered
                    ? (c) => ['INR', 'CAD', 'USD', 'CHF', 'EUR', 'KES']
                        .contains(c.currencyCode)
                    : null,
                onValuePicked: (Country? country) {
                  print("${country?.name}");
                },
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(
                fontFamily: 'Gilmer',
                fontSize: 14,
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.w700,
              ),
              controller: widget.controller,
              // initialValue: _formatter.format('0000'),
              // inputFormatters: [CurrencyTextInputFormatter(
              //   locale: 'en',
              // )],

              keyboardType: TextInputType.number,
                        
              // validator: widget.validator,
              // onChanged: widget.onChanged,
              cursorColor: Theme.of(context).colorScheme.tertiary,
              decoration: InputDecoration(
                focusColor: Theme.of(context).colorScheme.tertiary,
                border: InputBorder.none,
                // prefixIcon: Icon(Icons.euro_symbol_rounded,
                //     color: Theme.of(context).colorScheme.tertiary),
                fillColor: Theme.of(context).colorScheme.secondary,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary, width: 0),
                ),
                hintText: widget.text,
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    fontFamily: "Gilmer",
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).hintColor),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                    width: 2,
                  ),
                ),
              ),
            ),
          )
        ],
      );

  // Future<void> _setDefaultCountry() async {
  //   // 
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
  //     case 'United Kingdom':
  //       return CscCountry.United_Kingdom;
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
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilmer',
              fontSize: 12,
            ),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: _buildCurrencyPickerDropdown(true)),
        
        const Padding(padding: EdgeInsets.symmetric(vertical: 7)),
      ],
    );
  }
}
