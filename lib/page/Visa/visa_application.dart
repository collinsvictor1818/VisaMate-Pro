// ignore_for_file: prefer_const_constructors, library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visamate/component/appbar.dart';
import 'package:visamate/component/currency_picker.dart';
import 'package:visamate/component/fire_options.dart';
import 'package:visamate/screens/Register/member_details_screen.dart';
import 'package:visamate/screens/Register/view_members.dart';
import 'package:visamate/utils/list.dart';
import 'package:flutter/material.dart';
import 'package:visamate/component/form/CustomButton.dart';
import 'package:visamate/component/Form/FormBirthday.dart';
import 'package:visamate/component/Form/FormText.dart';
import 'package:visamate/component/constants/List.dart';
import '../../../component/Form/FormOptions.dart';
import '../../../component/Form/FormTitle.dart';
import '../../component/Form/FormFormField.dart';
import 'package:visamate/component/snacky.dart' as snackBarHelper;

import '../../component/country_picker.dart';
import '../../component/custom_calendar.dart';

class VisaApplication extends StatefulWidget {
  final String? username;

  const VisaApplication({this.username});

  @override
  State<VisaApplication> createState() => _VisaApplicationState();
}

class _VisaApplicationState extends State<VisaApplication> {
  final TextEditingController _firstNameConroller = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _duration = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  bool isSliderInteracted = false;

  DateTime? selectedEndDate;
  DateTime? selectedStartDate;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  Future<bool> doesfirstExist(String first) async {
    try {
      final members = FirebaseFirestore.instance.collection("members");
      final firstQuery = members.where("first", isEqualTo: first);
      final firstSnapshot = await firstQuery.get();
      return firstSnapshot.size > 0;
    } catch (e) {
      print("Error checking first existence: $e");
      return false; // Return false in case of an error
    }
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

  void _VisaApplication() async {
    final snacky = snackBarHelper.SnackBarHelper(context);
    final String first = _firstNameConroller.text.trim();
    final String last = _lastNameController.text.trim();
    final String phone = _phonenumberController.text.trim();
    final String nationality = _nationalityController.text.trim();
    final String branch = _branchController.text.trim();
    final String religion = _religionController.text.trim();
    final String birthday = _birthdayController.text.trim();
    final String location = _locationController.text.trim();
    // final String first = _.text.trim();
    // final String phone = _lastNameController.text.trim();

    // if (first.isEmpty) {
    //   snacky.showSnackBar("First name field is empty", isError: true);
    //   return;
    // }

    // if (last.isEmpty) {
    //   snacky.showSnackBar("Last name field is empty", isError: true);
    //   return;
    // }
    // if (phone.isEmpty) {
    //   snacky.showSnackBar("Phonenumber field is empty", isError: true);
    //   return;
    // }
    // if (birthday.isEmpty) {
    //   snacky.showSnackBar("Birthday field is empty", isError: true);
    //   return;
    // }
    if (nationality.isEmpty) {
      snacky.showSnackBar("Nationality field is empty", isError: true);
      return;
    }
    if (religion.isEmpty) {
      snacky.showSnackBar("Religion field is empty", isError: true);
      return;
    }
    // if (group.isEmpty) {
    //   snacky.showSnackBar("Church field is empty", isError: true);
    //   return;
    // }
    // if (branch.isEmpty) {
    //   snacky.showSnackBar("Branch field is empty", isError: true);
    //   return;
    // }
    if (location.isEmpty) {
      snacky.showSnackBar("location field is empty", isError: true);
      return;
    }

    if (await doesPhoneNumberExist(phone)) {
      snacky.showSnackBar("Phone number exists, use a different one",
          isError: true);
      return;
    }

    try {
      // Generate a password
      // Generate the username
      String username = _generateUsername(first, last, phone);

      // // Add the member's data to the database
      // await FirebaseFirestore.instance.collection("members").add({
      //   'first': first,
      //   'last': last,
      //   'location': location,
      //   'nationality': nationality,
      //   'group': group,
      //   'branch': branch,
      //   'religion': religion,
      //   'phone': phone, // Store the phone number as a string
      //   'password': location,
      //   'terms_accepted': birthday,
      // });

      // Navigate to the login screen
      // ignore: use_build_context_synchronously

      // Generate the username
      // String username = _generateUsername(first, last, phone);

      DocumentReference newMemberRef =
          await FirebaseFirestore.instance.collection("members").add({
        'username': username,
        'first': first,
        'last': last,
        'location': location,
        'nationality': nationality,
        'group': group,
        'branch': branch,
        'religion': religion,
        'phone': phone,
        'password': location,
        'terms_accepted': birthday,
      });

      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => ViewMembers()));

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MemberDetailsScreen(
          memberRef: newMemberRef,
          // Pass any other necessary data here
        ),
      ));

      // ignore: use_build_context_synchronously
      // Alert.show(
      //   context,
      //   title: 'Password',
      //   message: password,
      //   isError: true,
      // );
    } catch (e) {
      snacky.showSnackBar("An error occurred: $e", isError: true);
      print("An error occurred: $e");
    }
  }

  Stream<QuerySnapshot> _getMembersStream() {
    return FirebaseFirestore.instance.collection("members").snapshots();
  }

  Future<bool> doesPhoneNumberExist(String phoneNumber) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("members")
          .where("phone", isEqualTo: phoneNumber)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking phone number existence: $e");
      return false;
    }
  }

  String _generateUsername(String first, String last, String phone) {
    // Extract last name initials
    String lastNameInitials = last.isNotEmpty ? last[0].toUpperCase() : '';

    // Extract the last 3 digits of the phone number
    String lastDigits =
        phone.length >= 3 ? phone.substring(phone.length - 3) : phone;

    // Combine to create the username
    String username = '$first-${lastNameInitials}-$lastDigits';
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Visa Application",
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              width: 350,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FormDropDown(
                      text: "Reason for travel",
                      list: visaReasons,
                      desc: 'Specify the reason to travel ',
                      controller: _religionController,
                    ),
                    FormDropDown(
                      text: "Religion",
                      list: religions,
                      desc: "Choose your religious affiliation (optional)",
                      controller: _religionController,
                    ),

                    CountryPicker(
                      text: 'Location',
                      desc: "Select your country of citizenship",
                    ),
                    CurrencyPicker(
                      text: 'Budget',
                      desc: 'Specify your Budget',
                    ),

                    CustomCalendarView(
                      text: "Duration of Stay",
                      desc: 'Select your desired arrival and departure dates',
                      durationChange: (duration) {
                        _duration.text = duration.toString();
                      },
                      selectEndDateChange: onEndDateSelected,
                      selectStartDateChange: onStartDateSelected,
                    ),

                    FormButton(
                      text: 'Apply',
                      action: () {
                        _VisaApplication();
                      },
                    ),
                    SizedBox(height: 20),
                    // Add a StreamBuilder to display the data
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _buildStream() {
    StreamBuilder<QuerySnapshot>(
      stream: _getMembersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Extract and display the data
        final members = snapshot.data!.docs;
        return Column(
          children: members.map((member) {
            final firstName = member['first'];
            final lastName = member['last'];
            final phoneNumber = member['phone'];

            return ListTile(
              title: Text('$firstName $lastName'),
              subtitle: Text('Phone: $phoneNumber'),
            );
          }).toList(),
        );
      },
    );
  }
}
