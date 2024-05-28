import 'package:visamate/component/appbars/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../component/Form/FormOptions.dart';
import '../../component/Form/FormText.dart';
import '../../component/Form/TextAction.dart';
import '../../component/cards/check_box_card.dart';
import '../../component/constants/List.dart';
// import 'report_pdf.dart';
import '../../component/listview/ListBuilder.dart';
import '../../styles/pallete.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:visamate/component/currency_picker.dart';
import '../../component/country_picker.dart';
import '../../component/custom_calendar.dart';

import 'package:visamate/component/form/CustomButton.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int activeStep = 0;
  List<bool> isSelectedList = [];
  bool isLoading = true;
  List<QueryDocumentSnapshot> members = [];
  Map<String, bool> UserProfileMap = {};
  TextEditingController _serviceType = TextEditingController();
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  // final TextEditingController _educationController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _duration = TextEditingController();
  // final TextEditingController _birthdayController = TextEditingController();
  // final TextEditingController _branchController = TextEditingController();
  bool isSliderInteracted = false;

  DateTime? selectedEndDate;
  DateTime? selectedStartDate;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  TextEditingController _datePicker = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    fetchMemberDataFromFirestore();
  }

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).brightness == Brightness.light
              ? ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Theme.of(context).colorScheme.tertiary,
                    onPrimary: Theme.of(context).colorScheme.onBackground,
                  ),
                  textTheme: const TextTheme(
                      bodyLarge: TextStyle(
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColor.dark),
                      bodyMedium: TextStyle(
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColor.dark),
                      bodySmall: TextStyle(
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColor.dark)),
                  // Customize other light theme properties here
                )
              : ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: Theme.of(context).colorScheme.tertiary,
                    onPrimary: Theme.of(context).colorScheme.onBackground,
                  ),
                  textTheme: const TextTheme(
                      bodyLarge: TextStyle(
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColor.dark),
                      bodyMedium: TextStyle(
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColor.dark),
                      bodySmall: TextStyle(
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColor.dark)),
                  // Customize other dark theme properties here
                ),
          child: child!,
        );
      },
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).brightness == Brightness.light
              ? ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Theme.of(context).colorScheme.tertiary,
                    onPrimary: Theme.of(context).colorScheme.onBackground,
                  ),
                  textTheme: const TextTheme(
                      bodyLarge: TextStyle(
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColor.dark),
                      bodyMedium: TextStyle(
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColor.dark),
                      bodySmall: TextStyle(
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColor.dark)),
                  // Customize other light theme properties here
                )
              : ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: Theme.of(context).colorScheme.tertiary,
                    onPrimary: Theme.of(context).colorScheme.onBackground,
                  ),
                  textTheme: const TextTheme(
                      bodyLarge: TextStyle(
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColor.dark),
                      bodyMedium: TextStyle(
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColor.dark),
                      bodySmall: TextStyle(
                          fontFamily: "Gilmer",
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColor.dark)),
                  // Customize other dark theme properties here
                ),
          child: child!,
        );
      },
    );
  }

  // Function to save information to Firestore
  Future<void> saveToFirestore(
      List<Map<String, dynamic>> members, String sType) async {
    try {
      final CollectionReference membersCollection =
          FirebaseFirestore.instance.collection('members');

      for (var member in members) {
        // Query Firestore to find the document ID of the member
        QuerySnapshot querySnapshot = await membersCollection
            .where('first', isEqualTo: member['first'])
            .where('last', isEqualTo: member['last'])
            .limit(1)
            .get();

        // Check if the member exists
        if (querySnapshot.docs.isNotEmpty) {
          String memberId = querySnapshot.docs.first.id;

          // Update the existing member's UserProfile information
          await membersCollection.doc(memberId).update({
            'serviceAttended': sType ?? 'Service',
          });

          print('UserProfile updated for ${member['first']} ${member['last']}');
        } else {
          print(
              'Member ${member['first']} ${member['last']} not found in Firestore.');
        }
      }

      print('Information saved to Firestore successfully!');
    } catch (e) {
      print('Error saving information to Firestore: $e');
    }
  }

  Widget buildDatePicker() {
    return DatePicker(
      text: 'Date',
      controller: _datePicker,
    );
  }

  Future<void> fetchMemberDataFromFirestore() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('members')
          .limit(10)
          .get();

      setState(() {
        members = querySnapshot.docs;
        isSelectedList = List.filled(members.length, true);
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    String sType = _serviceType.text.toString();
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            title: "User Profile",
            onClickedBack: () {},
            onClickedHome: () {},
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.tertiary))
              : Center(
                  child: SizedBox(
                    width: 400,
                    child: Column(children: [
                      NumberStepper(
                        stepRadius: 15,
                        stepPadding: 0.0,
                        numbers: const [1, 2, 3],
                        lineColor: Theme.of(context).colorScheme.tertiary,
                        activeStepColor: Theme.of(context).colorScheme.tertiary,
                        activeStepBorderColor:
                            Theme.of(context).colorScheme.tertiary,
                        stepColor: Theme.of(context).colorScheme.onBackground,
                        activeStep: activeStep,
                        onStepReached: (index) {
                          setState(() {
                            activeStep = index;
                          });
                        },
                      ),
                      Expanded(
                        child: IndexedStack(
                          index: activeStep,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  // FormDropDown(
                                  //   text: "Reason for travel",
                                  //   list: visaReasons,
                                  //   desc: 'Specify the reason to travel ',
                                  //   controller: _religionController,
                                  // ),
                                  //  FormText(
                                  //   text: 'First Name',
                                  //   desc: 'Your first official name according to your passport',
                                  // controller: _firstNameController,
                                  // ),
                                  //                                    FormText(
                                  //   text: 'Middle Name',
                                  //   desc: 'Your second official name according to your passport',
                                  // controller: _middleNameController,
                                  // ),
                                  //                                    FormText(
                                  //   text: 'Last Name',
                                  //   controller: _lastNameController,
                                  //   desc: 'Your third official name according to your passport'
                                  // ),
                                  FormDropDown(
                                    text: "Religion",
                                    list: religions,
                                    desc:
                                        "Choose your religious affiliation (optional)",
                                    controller: _religionController,
                                  ),
                                  FormDropDown(
                                    text: "Language",
                                    list: languages,
                                    desc: "Choose your prefered language)",
                                    controller: _religionController,
                                  ),
                                  CountryPicker(
                                    text: 'Country of Citizenship',
                                    desc: "Select your country of citizenship",
                                    controller: _locationController,
                                  ),
                                  // const CurrencyPicker(
                                  //   text: 'Budget',
                                  //   desc: 'Specify your Budget',
                                  // ),

                               
                                  const Spacer(flex: 1),
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
                                                      const EdgeInsets.all(8.0),
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
                                          if (activeStep < 2) activeStep++;
                                        }),
                                        // onTap: () {
                                        // if (_serviceType.text.isNotEmpty &&
                                        //     isAnySelectionMade()) {
                                        //   setState(() {
                                        //     if (activeStep < 2) activeStep++;
                                        //   });
                                        // } else {
                                        //   String message;
                                        //   if (_serviceType.text.isEmpty) {
                                        //     message =
                                        //         'Please select a service type.';
                                        //   } else {
                                        //     message =
                                        //         'Please select at least one member.';
                                        //     activeStep++;
                                        //   }
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(SnackBar(
                                        //     content: Text(message),
                                        //   ));
                                        // }
                                        // },
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
                                                      const EdgeInsets.all(8.0),
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
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                              const    SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        // for (var i = 0; i < members.length; i++)
                                        //   CheckBoxCard(
                                        //     member: members[i]['first'] ?? '',
                                        //     last: members[i]['last'] ?? '',
                                        //     isSelected: isSelectedList[i],
                                        //     onSelectionChange:
                                        //         (isSelected, reason) {
                                        //       setState(() {
                                        //         isSelectedList[i] = isSelected;
                                        //         if (isSelected) {
                                        //           UserProfileMap[members[i].id] =
                                        //               true;
                                        //         } else {
                                        //           UserProfileMap
                                        //               .remove(members[i].id);
                                        //         }
                                        //       });
                                        //     },
                                        //   ),
                                        // ListView(children: <Widget>[
                                        //           const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                                        const Text(
                                          'Reason for Travel',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        // BuildList(
                                        //   icon: Icons.airlines_rounded,
                                        //   title: "Work/Business",
                                        //   desc: "Work Related",
                                        //   onClicked: () {
                                        //     // Navigator.of(context).push(
                                        //     //     MaterialPageRoute(builder: ((context) => AddZone())));
                                        //   },
                                        // ),
                                        // BuildList(
                                        //   icon: Icons.airlines_rounded,
                                        //   title: "Study",
                                        //   desc: "Educational purposes",
                                        //   onClicked: () {
                                        //     // Navigator.of(context).push(
                                        //     //     MaterialPageRoute(builder: ((context) => AddBranch())));
                                        //   },
                                        // ),
                                      
                                        // BuildList(
                                        //   icon: Icons.airlines_rounded,
                                        //   title: "Tourism",
                                        //   desc: "Adventure",
                                        //   onClicked: () {
                                        //     // Navigator.of(context).push(
                                        //   },
                                        // ),

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
                                                      const EdgeInsets.all(8.0),
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
                                        onTap: () => setState(() {
                                          if (activeStep < 2) activeStep++;
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
                                                      const EdgeInsets.all(8.0),
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
                            ),
                            Column(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0).add(const EdgeInsets.symmetric(horizontal: 20)),
                                    child: Column(
                                        // children: members
                                        //     .map((member) => Summary(
                                        //           member: member['first'] ?? '',
                                        //           last: member['last'] ?? '',
                                        //           isSelected: isSelectedList[
                                        //               members.indexOf(member)],
                                        //           serviceAttended:
                                        //               sType ?? 'Service',
                                        //         ))
                                        //     .toList(),
                                        children: [
                                          // FormDropDown(
                                          //   text: "Reason for travel",
                                          //   list: visaReasons,
                                          //   desc:
                                          //       'Specify the reason to travel ',
                                          //   controller: _religionController,
                                          // ),
                                          // FormDropDown(
                                          //   text: "Religion",
                                          //   list: religions,
                                          //   desc:
                                          //       "Choose your religious affiliation (optional)",
                                          //   controller: _religionController,
                                          // ),

                                          // const CountryPicker(
                                          //   text: 'Location',
                                          //   desc:
                                          //       "Select your country of citizenship",
                                          // ),
                                             CustomCalendarView(
                                    text: "Duration of Stay",
                                    desc:
                                        'Select your desired arrival and departure dates',
                                    durationChange: (duration) {
                                      _duration.text = duration.toString();
                                    },
                                    selectEndDateChange: onEndDateSelected,
                                    selectStartDateChange: onStartDateSelected,
                                  ),
                                  FormButton(
                                    text: 'Save',
                                    action: () {
                                      // _VisaApplication();
                                    },
                                  ),

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
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0).add(const EdgeInsets.symmetric(vertical: 20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                    borderRadius:
                                                        BorderRadius.circular(5)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                          List<Map<String, dynamic>> memberData =
                                              members
                                                  .map((snapshot) =>
                                                      snapshot.data()
                                                          as Map<String, dynamic>)
                                                  .toList();
                                  
                                          // Navigate to Report PDF screen with necessary data
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //     builder: (context) => ReportPDF(
                                          //       members: memberData,
                                          //       sType: sType,
                                          //     ),
                                          //   ),
                                          // );
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
                                                        .tertiary,
                                                    borderRadius:
                                                        BorderRadius.circular(5)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                      child: Text('Apply',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .background,
                                                              fontSize: 18))),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                )),
    );
  }

  Widget generateSummary() {
    // Extract present members
    final presentMembers = UserProfileMap.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    // Extract absent members
    final absentMembers =
        members.where((member) => !presentMembers.contains(member.id)).toList();

    return Column(
      children: [
        Text('Present Members:'),
        presentMembers.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: presentMembers.length,
                itemBuilder: (context, index) => Text(presentMembers[index]),
              )
            : Text('No members present'),
        SizedBox(height: 20),
        Text('Absent Members:'),
        absentMembers.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: absentMembers.length,
                itemBuilder: (context, index) =>
                    Text(absentMembers[index]['first'] ?? ''),
              )
            : Text('All members present'),
      ],
    );
  }

  bool isAnySelectionMade() {
    return isSelectedList.any((selected) => selected);
  }
}

class Summary extends StatelessWidget {
  final String member;
  final String last;
  final bool isSelected;
  final String serviceAttended;

  const Summary({
    Key? key,
    required this.member,
    required this.last,
    required this.isSelected,
    required this.serviceAttended,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          title: Text('$member $last'),
          subtitle: Container(
            width: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isSelected
                    ? Theme.of(context).colorScheme.tertiary.withOpacity(0.1)
                    : Theme.of(context).colorScheme.error.withOpacity(0.1)),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  isSelected ? 'Present' : 'Absent',
                  style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.error),
                ),
              ),
            ),
          ),
          trailing: Text(
            serviceAttended,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700), // Display service attended
            // No need for a Checkbox in this modified version
            // onChanged: onSelectionChange,
          ),
        ));
  }
}
