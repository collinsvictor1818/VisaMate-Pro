import 'package:flutter/material.dart';
import 'package:visamate/component/snacky.dart' as snackBarHelper;
import '../../../component/custom_calendar.dart';
import '../../../component/form_text.dart';
import '../../../component/listview/ListBuilder.dart';

class DurationWidget extends StatefulWidget {
  const DurationWidget(BuildContext? context);

  @override
  State<DurationWidget> createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<DurationWidget> {
  
  DateTime? selectedEndDate;
  DateTime? selectedStartDate;
  void onStartDateSelected(DateTime startDate, DateTime endDate) {
    setState(() {
      selectedStartDate = startDate;
    });
  }

  void onEndDateSelected(DateTime startDate, DateTime endDate) {
    setState(() {
      selectedEndDate = endDate;
    });
  }


  @override
  Widget build(BuildContext context) {
    return _DurationWidget(context);
  }

Widget _DurationWidget(BuildContext context) {
  int activeStep = 0;
  final TextEditingController _durationController = TextEditingController();
                           return     Expanded(
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0).add(
                                            const EdgeInsets.symmetric(
                                                horizontal: 20)),
                                        child: Column(children: [
                                          CustomCalendarView(
                                            text: "Duration of Stay",
                                            desc:
                                                'Select your desired arrival and departure dates',
                                            durationChange: (duration) {
                                              _durationController.text =
                                                  duration.toString();
                                            },
                                            selectEndDateChange:
                                                onEndDateSelected,
                                            selectStartDateChange:
                                                onStartDateSelected,
                                          ),
                                          // FormButton(
                                          //   text: 'Save',
                                          //   action: () {
                                          //     // _VisaApplication();
                                          //   },
                                          // ),

                                          // // const CurrencyPicker(
                                          //   text: 'Budget',
                                          //   desc: 'Specify your Budget',
                                          // ),

                                          // CustomCalendarView(
                                          //   text: "Duration of Stay",
                                          //   desc:
                                          //       'Select your desired arrival and departure dates',
                                          //   durationChange: (duration) {
                                          //     _duration.text = duration.toString();
                                          //   },
                                          //   selectEndDateChange: onEndDateSelected,
                                          //   selectStartDateChange: onStartDateSelected,
                                          // ),
                                          // FormButton(
                                          //   text: 'Apply',
                                          //   action: () {
                                          //     // _VisaApplication();
                                          //   },
                                          // ),
                                        ]),
                                      ),
                                    ),
                                    Spacer(flex: 1),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0)
                                          .add(const EdgeInsets.symmetric(
                                              vertical: 20)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                              onTap: () => setState(() {
                                                    // if (activeStep > 4)
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
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                          child: Text(
                                                              'Previous',
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .tertiary,
                                                                  fontSize:
                                                                      18))),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          GestureDetector(
                                            // onTap: () {
                                            //   if (isAnySelectionMade()) {
                                            //     setState(() {
                                            //       if (activeStep < 2) activeStep++;
                                            //     });
                                            //   } else {
                                            //     ScaffoldMessenger.of(context)
                                            //         .showSnackBar(const SnackBar(
                                            //       content: Text(
                                            //           'Please select at least one member.'),
                                            //     ));
                                            //   }
                                            // },
                                            onTap: () async {
                                              // Convert List<QueryDocumentSnapshot<Object?>> to List<Map<String, dynamic>>

                                              // List<Map<String, dynamic>>
                                              //     memberData = members
                                              //         .map((snapshot) => snapshot
                                              //                 .data()
                                              //             as Map<String, dynamic>)
                                              //         .toList();
                                              // if (_formKey.currentState.validate()) {
                                              final String duration =
                                                  _durationController
                                                      .toString();
                                              final snacky =
                                                  snackBarHelper.SnackBarHelper(
                                                      context);
                                              if (duration.isEmpty) {
                                                snacky.showSnackBar(
                                                    "Select stay duration",
                                                    isError: true);

                                                return;
                                              } else {
                                                // _getVisaRecommendations();
                                                return;
                                              }
                                            },
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
                                                            .tertiary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                          child: Text('Save',
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .background,
                                                                  fontSize:
                                                                      18))),
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                         }
}