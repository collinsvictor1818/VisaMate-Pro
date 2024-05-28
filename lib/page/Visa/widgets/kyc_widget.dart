import 'package:flutter/material.dart';
import 'package:visamate/component/Form/FormOptions.dart';
import 'package:visamate/component/snacky.dart' as snackBarHelper;
import '../../../component/constants/List.dart';
import '../../../component/country_picker.dart';
import '../../../component/form_text.dart';

class KYCWidget extends StatefulWidget {
  const KYCWidget(BuildContext? context);

  @override
  State<KYCWidget> createState() => _KYCWidgetState();
}

class _KYCWidgetState extends State<KYCWidget> {
  @override
  Widget build(BuildContext context) {
    return _KYCWidget(context);
  }

Widget _KYCWidget(context) {
  int activeStep =0;
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          FormDropDown(
            text: "Religion",
            list: religions,
            desc: "Choose your religious affiliation (optional)",
            controller: _religionController,
          ),
          FormDropDown(
            text: "Language",
            list: languages,
            desc: "Choose your prefered language)",
            controller: _languageController,
          ),
          CountryPicker(
            text: 'Country of Citizenship',
            desc: "Select your country of citizenship",
            controller: _countryController,
          ),
          const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                        // if (activeStep >1)
                        activeStep--;
                      },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                          maxHeight: 50,
                          minHeight: 50,
                          maxWidth: 144,
                          minWidth: 100),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text('Previous',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 18))),
                        ),
                      ),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  // if (activeStep < 3) activeStep++;
                  final String religion = _religionController.toString();
                  final String country = _countryController.toString();
                  final String language = _languageController.toString();
                  final snacky = snackBarHelper.SnackBarHelper(context);
                  if (religion.isEmpty && country.isEmpty && religion.isEmpty) {
                    snacky.showSnackBar("Fill in all details", isError: true);

                    return;
                  } else if (country.isEmpty) {
                    snacky.showSnackBar("Fill in your country of citizenship",
                        isError: true);
                    return;
                  } else if (language.isEmpty) {
                    snacky.showSnackBar("Fill in your language preference",
                        isError: true);
                    return;
                  } else if (religion.isEmpty) {
                    snacky.showSnackBar("Fill in your religious obligation",
                        isError: true);
                    return;
                  } else if (activeStep < 3) {
                    activeStep++;
                  } else {
                    return;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        maxHeight: 50,
                        minHeight: 50,
                        maxWidth: 144,
                        minWidth: 100),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text('Next',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 18))),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}