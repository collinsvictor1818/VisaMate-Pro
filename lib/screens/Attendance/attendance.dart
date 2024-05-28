import 'package:visamate/component/appbars/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../component/Form/FormOptions.dart';
import '../../component/Form/TextAction.dart';
import '../../component/cards/check_box_card.dart';
import '../../component/constants/List.dart';
import 'report_pdf.dart';
import '../../styles/pallete.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MemberAttendance extends StatefulWidget {
  const MemberAttendance({Key? key}) : super(key: key);

  @override
  State<MemberAttendance> createState() => _MemberAttendanceState();
}

class _MemberAttendanceState extends State<MemberAttendance> {
  int activeStep = 0;
  List<bool> isSelectedList = [];
  bool isLoading = true;
  List<QueryDocumentSnapshot> members = [];
  Map<String, bool> attendanceMap = {};
  TextEditingController _serviceType = TextEditingController();
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  TextEditingController _datePicker = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    fetchMemberDataFromFirestore();
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

          // Update the existing member's attendance information
          await membersCollection.doc(memberId).update({
            'serviceAttended': sType ?? 'Service',
          });

          print('Attendance updated for ${member['first']} ${member['last']}');
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
            title: "Attendance",
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
                                  FormDropDown(
                                    text: 'Service Type',
                                    list: serviceType,
                                    controller: _serviceType,
                                  ),
                                  // ElevatedButton(child: Text('Time'), onPressed: (){buildDatePicker();}),
                                  //                         GestureDetector(
                                  //   onTap: () => _selectTime(context),
                                  //   child: TimePicker(
                                  //                           text: 'Time',
                                  //                           hint: ' ${_selectedTime.hour}:${_selectedTime.minute}',
                                  //                           onClicked:() => _selectTime(context),
                                  //                         ),
                                  // ),
                                  //                      GestureDetector(
                                  //   onTap: () => _selectTime(context),
                                  //                         child: TimePicker(
                                  //                           text: 'Time',
                                  //                           onClicked:() => _selectTime(context),
                                  //                         ),
                                  //                       ), // SizedBox(height: 20),
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
                                        onTap: () {
                                          if (_serviceType.text.isNotEmpty &&
                                              isAnySelectionMade()) {
                                            setState(() {
                                              if (activeStep < 2) activeStep++;
                                            });
                                          } else {
                                            String message;
                                            if (_serviceType.text.isEmpty) {
                                              message =
                                                  'Please select a service type.';
                                            } else {
                                              message =
                                                  'Please select at least one member.';
                                              activeStep++;
                                            }
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(message),
                                            ));
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
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (var i = 0; i < members.length; i++)
                                          CheckBoxCard(
                                            member: members[i]['first'] ?? '',
                                            last: members[i]['last'] ?? '',
                                            isSelected: isSelectedList[i],
                                            onSelectionChange:
                                                (isSelected, reason) {
                                              setState(() {
                                                isSelectedList[i] = isSelected;
                                                if (isSelected) {
                                                  attendanceMap[members[i].id] =
                                                      true;
                                                } else {
                                                  attendanceMap
                                                      .remove(members[i].id);
                                                }
                                              });
                                            },
                                          ),
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
                                        onTap: () {
                                          if (isAnySelectionMade()) {
                                            setState(() {
                                              if (activeStep < 2) activeStep++;
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please select at least one member.'),
                                            ));
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
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: members
                                          .map((member) => Summary(
                                                member: member['first'] ?? '',
                                                last: member['last'] ?? '',
                                                isSelected: isSelectedList[
                                                    members.indexOf(member)],
                                                serviceAttended:
                                                    sType ?? 'Service',
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                Spacer(flex: 1),
                                Row(
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
                                            constraints: BoxConstraints(
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
                                      onTap: () async {
                                        // Convert List<QueryDocumentSnapshot<Object?>> to List<Map<String, dynamic>>
                                        List<Map<String, dynamic>> memberData =
                                            members
                                                .map((snapshot) =>
                                                    snapshot.data()
                                                        as Map<String, dynamic>)
                                                .toList();

                                        // Navigate to Report PDF screen with necessary data
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ReportPDF(
                                              members: memberData,
                                              sType: sType,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
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
                                                    child: Text('Submit',
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
    final presentMembers = attendanceMap.entries
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
