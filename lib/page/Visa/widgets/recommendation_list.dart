import 'package:flutter/material.dart';
import 'package:visamate/component/snacky.dart' as snackBarHelper;
import '../../../component/cards/recommended_card.dart';
import '../../../component/form_text.dart';
import '../../../component/listview/ListBuilder.dart';

class RecommendationList extends StatefulWidget {
  const RecommendationList(BuildContext? context);

  @override
  State<RecommendationList> createState() => _RecommendationListState();
}

class _RecommendationListState extends State<RecommendationList> {
  @override
  Widget build(BuildContext context) {
    return _RecommendationList(context);
  }

  Widget _RecommendationList(BuildContext context) {
    int activeStep = 0;
    final TextEditingController _reasonController = TextEditingController();
    final TextEditingController _middleNameController = TextEditingController();
    final TextEditingController _lastNameController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // for (var i = 0; i < members.length; i++)
                //   CheckBoxCard(
                //     member: members[i]['first'] ?? '',
                //     last: members[i]['last'] ?? '',
                // isSelected: isSelectedList[i],
                // onSelectionChange:
                //     (isSelected, reason) {
                //   setState(() {
                //     isSelectedList[i] = isSelected;
                //     if (isSelected) {
                //       SetupProfileMap[members[i].id] =
                //           true;
                //     } else {
                //       SetupProfileMap
                //           .remove(members[i].id);
                //     }
                //   });
                // },
                //   ),
                // ListView(children: <Widget>[
                //           const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                const Text(
                  'Reason for Travel',
                  style: TextStyle(fontSize: 20),
                ),
                RecommendationCard(code: 'KE', visa: '',),
                RecommendationCard(code: 'UG', visa: '',),
                RecommendationCard(code: 'TZ', visa: '',),
                RecommendationCard(code: 'SA', visa: '',),
                RecommendationCard(code: 'SO', visa: '',),
                RecommendationCard(code: 'GB', visa: '',),
                // ]),
              ],
            ),
          ),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () => setState(() {
                        if (activeStep > 0) activeStep--;
                      }),
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
                onTap: () => setState(() {
                  // final String religion =
                  //     _religionController.toString();
                  // final String country =
                  //     _countryController.toString();
                  // final String language =
                  //     _languageController.toString();
                  // final snacky =
                  //     snackBarHelper.SnackBarHelper(
                  //         context);
                  // if (religion.isEmpty &&
                  //     country.isEmpty &&
                  //     religion.isEmpty) {
                  //   snacky.showSnackBar(
                  //       "Fill in all details",
                  //       isError: true);

                  //   return;
                  // } else if (country.isEmpty) {
                  //   snacky.showSnackBar(
                  //       "Fill in your country of citizenship",
                  //       isError: true);
                  //   return;
                  // } else if (language.isEmpty) {
                  //   snacky.showSnackBar(
                  //       "Fill in your language preference",
                  //       isError: true);
                  //   return;
                  // } else if (religion.isEmpty) {
                  //   snacky.showSnackBar(
                  //       "Fill in your religious obligation",
                  //       isError: true);
                  //   return;
                  // } else if (activeStep < 5) {
                  //   activeStep++;
                  // } else {
                  //   // activeStep++;
                  //   return;
                  // }
                }),
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
    );
  }
}
