import 'package:visamate/component/Form/FormOptions.dart';
import 'package:visamate/component/constants/List.dart';
import 'package:visamate/component/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:visamate/styles/pallete.dart';

import '../page/CostAnalysis/cost_analysis_tool.dart';
import '../page/M-Pesa/Tithe.dart';
import '../page/Visa/country_information.dart';
import '../screens/M-Pesa/Tithe.dart';
import '../screens/Map/map_screen.dart';
import '../screens/Settings/settings_screen.dart';
import '../screens/visa_requirements.dart';

class SnackBarHelper {
  final BuildContext context;
  final TextEditingController? monthController;
  final TextEditingController? yearController;

  SnackBarHelper(this.context, {this.monthController, this.yearController});

  void showPrompt() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Theme.of(context).colorScheme.background,
            ),
            child: ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                
                buildCustomMenuItem(
                  "Log out",
                  () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) =>  Schedule(),
                    // ));
                     Navigator.pop(context, true);
                     
                  },
                ),
                buildCustomMenuItem(
                  "Settings",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDateSnack() {
    DateSnack(context, monthController, yearController).showDateSnack();
  }

  Widget buildCustomMenuItem(String title, VoidCallback onPressed) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.03),
      child: ListTile(
        // leading: Icon(Icons.),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Gilmer',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColor.orange,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
class Snacky {
  final BuildContext context;
  final TextEditingController? monthController;
  final TextEditingController? yearController;

  Snacky(this.context, {this.monthController, this.yearController});

  void showVisaInfo() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Theme.of(context).colorScheme.background,
            ),
            child: ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                buildCustomMenuItem(
                  "Country Information",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CountryInfo()),
                    );
                  },
                ),
                buildCustomMenuItem(
                  "Visa Requirements",
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  VisaInfoPage(),
                    ));
                  },
                // ),buildCustomMenuItem(
                //   "View Visa Applications",
                //   () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) =>  PickChild(),
                //     ));
                //   },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDateSnack() {
    DateSnack(context, monthController, yearController).showDateSnack();
  }

  Widget buildCustomMenuItem(String title, VoidCallback onPressed) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.03),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Gilmer',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColor.orange,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
class DateSnack {
  final BuildContext context;
  final TextEditingController? monthController;
  final TextEditingController? yearController;
  DateSnack(this.context, this.monthController, this.yearController);

  void showDateSnack() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Theme.of(context).colorScheme.background,
            ),
            height: 200, // Set the desired height
            // child: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     children: [
            //       Text(
            //         "Select Day and Month",
            //         style: TextStyle(
            //           color: Theme.of(context).colorScheme.tertiary,
            //           fontFamily: 'Gilmer',
            //           fontSize: 12,
            //           fontWeight: FontWeight.w800,
            //         ),
            //       ),
            //       Expanded(
            //         child: Row(
            //           children: [
            //             // Date Column
            //             Container(
            //               width: 180,
            //               child: buildColumn(
            //                 itemCount: 31,
            //                 itemBuilder: (BuildContext context, int index) =>
            //                     Center(
            //                   child: Text(
            //                     '${index + 1}',
            //                     style: TextStyle(
            //                       fontSize: 20,
            //                       color: Theme.of(context)
            //                           .colorScheme
            //                           .onBackground,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             // Month Column
            //             Expanded(
            //               child: buildColumn(
            //                 itemCount: 12,
            //                 itemBuilder: (BuildContext context, int index) =>
            //                     Container(
            //                   padding: EdgeInsets.only(left: 10),
            //                   child: Text(
            //                     getMonthName(index + 1),
            //                     style: TextStyle(
            //                       fontSize: 20,
            //                       color: Theme.of(context)
            //                           .colorScheme
            //                           .onBackground,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FormDropDown(
                            text: 'Month ',
                            list: months,
                          ),
                        ),

                        const SizedBox(
                            width: 8), // Add some spacing between the dropdowns
                        Expanded(
                          child: FormDropDown(
                            text: 'Day',
                            list: days,
                          ),
                        ),
                      ],
                    ),

                    GestureDetector(
                      onTap: () {
                        String selectedMonth = monthController!.text
                            .trim(); // Get the text from the controller
                        String selectedYear = yearController!.text
                            .trim(); // Get the text from the controller

                        String birthday = '$selectedMonth/$selectedYear';
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      },
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 260.0,
                          maxWidth: 600.0,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                              child: Center(
                                child: Text(
                                  'Select',
                                  style: TextStyle(
                                    fontFamily: 'Gilmer',
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //  FormButton(text: 'Select', action: (){
                    //   String selectedMonth = monthController.toString().trim();
                    //   String selectedYear = yearController.toString().trim();

                    //     String birthday = '$selectedMonth/$selectedYear';
                    //      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    //   }
                    //  )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildColumn({
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
  }) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      scrollDirection: Axis.vertical, // Allow horizontal scrolling
    );
  }

  String getMonthName(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}
class Mpesa {
  final BuildContext context;
  final TextEditingController? monthController;
  final TextEditingController? yearController;

  Mpesa(this.context, {this.monthController, this.yearController});

  void showGivingOptions() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Theme.of(context).colorScheme.background,
            ),
            child: ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                buildCustomMenuItem(
                  "Visa",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Tithe()),
                    );
                  },
                ),
                buildCustomMenuItem(
                  "Travels",
                  () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) =>  Travel(),
                    // ));
                  },
                // ),buildCustomMenuItem(
                //   "Transactions",
                //   () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) =>  Schedule(),
                //     ));
                //   },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDateSnack() {
    DateSnack(context, monthController, yearController).showDateSnack();
  }

  Widget buildCustomMenuItem(String title, VoidCallback onPressed) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.03),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Gilmer',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColor.orange,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}