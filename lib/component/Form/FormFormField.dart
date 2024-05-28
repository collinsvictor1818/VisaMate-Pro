import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart' as intl_countries; // Import with a prefix
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:phonenumbers/phonenumbers.dart' as phone_numbers; // Import with a prefix
// import 'package:phonenumbers/phonenumbers.dart' as phone_numbers;

class FormPhoneField extends StatefulWidget {
  final String text;
  final String? hint;
  final TextEditingController? controller;
  final IconData? prefix;
  final IconData? suffix;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onClicked;
  final String? label;
  final TextInputType? keyboardType;

  const FormPhoneField({
    Key? key,
    required this.text,
    this.hint,
    this.onChanged,
    this.controller,
    this.prefix,
    this.suffix,
    this.validator,
    this.onClicked,
    this.label,
    this.keyboardType,
    required String title,
  }) : super(key: key);

  @override
  State<FormPhoneField> createState() => _FormPhoneFieldState();
}

class _FormPhoneFieldState extends State<FormPhoneField> {
  late intl_countries.Country _initialCountry; // Specify the prefix for the Country class
  late FocusNode focusNode;

// Future<void> checkPhoneNumber(String phoneNumberString) async {
//   try {
//     // Create an instance of PhoneNumberUtil
//    final phoneNumberUtil = phone_numbers.PhoneNumberUtil();

//     // Declare the phoneNumber variable before using it
//     final phoneNumber = phoneNumberUtil.parse(phoneNumberString, ''); // Provide the default region
//     // Check if the parsed phone number is valid
//     final isValid = phoneNumberUtil.isValidNumber(phoneNumber);
//     if (isValid) {
//       // Phone number is valid
//       print('Phone number $phoneNumberString is valid');
//     } else {
//       // Phone number is not valid
//       print('Phone number $phoneNumberString is not valid');
//     }
//   } catch (error) {
//     // Error occurred while validating phone number
//     print('Error validating phone number: $error');
//   }
// }

  @override
  void initState() {
    super.initState();
    // Initialize the initial country if the countries list is not empty
    if (countries.isNotEmpty) {
      _initialCountry = countries.firstWhere(
        (element) => element.code == 'KE',
        orElse: () => const Country(
          code: 'KE',
          name: 'Kenya',
          dialCode: '+254',
          minLength: 10,
          maxLength: 10,
          flag: "🇰🇪",
          nameTranslations: {
            "sk": "Keňa",
            "se": "Kenia",
            "pl": "Kenia",
            "no": "Kenya",
            "ja": "ケニア",
            "it": "Kenya",
            "zh": "肯尼亚",
            "nl": "Kenia",
            "de": "Kenia",
            "fr": "Kenya",
            "es": "Kenia",
            "en": "Kenya",
            "pt_BR": "Quênia",
            "sr-Cyrl": "Кенија",
            "sr-Latn": "Kenija",
            "zh_TW": "肯亞",
            "tr": "Kenya",
            "ro": "Kenya",
            "ar": "كينيا",
            "fa": "كنيا",
            "yue": "肯雅"
          },
        ),
      );
    } else {
      // Handle the case where the countries list is empty
      _initialCountry = const Country(
        code: 'KE',
        name: 'Kenya',
        dialCode: '+254',
        minLength: 9,
        maxLength: 10,
        flag: "🇰🇪",
        nameTranslations: {
          "sk": "Keňa",
          "se": "Kenia",
          "pl": "Kenia",
          "no": "Kenya",
          "ja": "ケニア",
          "it": "Kenya",
          "zh": "肯尼亚",
          "nl": "Kenia",
          "de": "Kenia",
          "fr": "Kenya",
          "es": "Kenia",
          "en": "Kenya",
          "pt_BR": "Quênia",
          "sr-Cyrl": "Кенија",
          "sr-Latn": "Kenija",
          "zh_TW": "肯亞",
          "tr": "Kenya",
          "ro": "Kenya",
          "ar": "كينيا",
          "fa": "كنيا",
          "yue": "肯雅"
        },
      );
    }
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.text,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
              fontFamily: "Gilmer",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: IntlPhoneField(
                  style: TextStyle(
                    fontFamily: 'Gilmer',
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  dropdownIcon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.start,
                  searchText: 'Select Country',
                  controller: widget.controller,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      widget.prefix,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    border: InputBorder.none,
                    fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 0,
                      ),
                    ),
                    hintText: widget.text,
                    hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).hintColor,
                        ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: 2,
                      ),
                    ),
                  ),
               onChanged: (phone) {
  if (phone != null && phone.number.trim().length == 10 && phone.number.trim().startsWith('0')) {
    String trimmedPhone = phone.number.trim().replaceFirst(RegExp('^0+'), '');
    widget.controller?.text = trimmedPhone;
  }
},
  onCountryChanged: (country) {
                    print('Country changed to: ${country.name}');
                  },
                  languageCode: "en",
                  focusNode: focusNode,
                  initialCountryCode: 'KE',
                  dropdownTextStyle:
                      TextStyle(
                            fontSize: 14,
                            fontFamily: "Gilmer",
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
  