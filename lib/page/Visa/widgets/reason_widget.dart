import 'package:flutter/material.dart';
import 'package:visamate/component/snacky.dart' as snackBarHelper;
import '../../../component/form_text.dart';
import '../../../component/listview/ListBuilder.dart';

class ReasonWidget extends StatefulWidget {
  const ReasonWidget(BuildContext? context);

  @override
  State<ReasonWidget> createState() => _ReasonWidgetState();
}

class _ReasonWidgetState extends State<ReasonWidget> {
  @override
  Widget build(BuildContext context) {
    return _reasonWidget(context);
  }

Widget _reasonWidget(BuildContext context) {
  int activeStep = 0;
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
                           return   Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          BuildList(
                                            icon: Icons.airlines_rounded,
                                            title: "Work/Business",
                                            desc: "Work Related",
                                            onClicked: () {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(builder: ((context) => AddZone())));
                                            },
                                            isSelected: true,
                                            onSelectionChange:
                                                (isSelected, reason) {
                                              setState(() {});
                                            },
                                          ),
                                          BuildList(
                                            icon: Icons.airlines_rounded,
                                            title: "Study",
                                            desc: "Educational purposes",
                                            onClicked: () {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(builder: ((context) => AddBranch())));
                                            },
                                            isSelected: true,
                                            onSelectionChange:
                                                (isSelected, reason) {
                                              setState(() {});
                                            },
                                          ),
                                          BuildList(
                                            icon: Icons.airlines_rounded,
                                            title: "Tourism",
                                            desc: "Adventure",
                                            isSelected: true,
                                            onSelectionChange:
                                                (isSelected, reason) {
                                              setState(() {});
                                            },
                                            onClicked: () {
                                              // Navigator.of(context).push(
                                            },
                                          ),

                                          // ]),
                                        ],
                                      ),
                                    ),
                                    Spacer(flex: 1),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () => setState(() {
                                                  if (activeStep > 0)
                                                    activeStep--;
                                                }),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                        child: Text('Previous',
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                        child: Text('Next',
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
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