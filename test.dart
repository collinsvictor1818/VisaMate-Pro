// import 'package:visamate/component/Form/FormText.dart';
// import 'package:visamate/component/custom_button.dart';
// import 'package:visamate/screens/Scheduling/timer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../component/appbars/CustomAppBar.dart';
// import '../../styles/pallete.dart';

// class DateTimePickerForm extends StatefulWidget {
//   const DateTimePickerForm({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _DateTimePickerFormState createState() => _DateTimePickerFormState();
// }

// class _DateTimePickerFormState extends State<DateTimePickerForm> {
//   late DateTime _selectedDate;
//   late TimeOfDay _selectedTime;
//   TextEditingController _activityController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     // Initialize selected date and time with current values
//     _selectedDate = DateTime.now();
//     _selectedTime = TimeOfDay.now();
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: Theme.of(context).brightness == Brightness.light
//               ? ThemeData.light().copyWith(
//                   colorScheme: ColorScheme.light(
//                     primary: Theme.of(context).colorScheme.tertiary,
//                     onPrimary: Theme.of(context).colorScheme.onBackground,
//                   ),
//                   textTheme: const TextTheme(
//                       bodyLarge: TextStyle(
//                           fontFamily: "Gilmer",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16,
//                           color: AppColor.dark),
//                       bodyMedium: TextStyle(
//                           fontFamily: "Gilmer",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                           color: AppColor.dark),
//                       bodySmall: TextStyle(
//                           fontFamily: "Gilmer",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 12,
//                           color: AppColor.dark)),
//                   // Customize other light theme properties here
//                 )
//               : ThemeData.dark().copyWith(
//                   colorScheme: ColorScheme.dark(
//                     primary: Theme.of(context).colorScheme.tertiary,
//                     onPrimary: Theme.of(context).colorScheme.onBackground,
//                   ),
//                   textTheme: const TextTheme(
//                       bodyLarge: TextStyle(
//                           fontFamily: "Gilmer",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16,
//                           color: AppColor.dark),
//                       bodyMedium: TextStyle(
//                           fontFamily: "Gilmer",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                           color: AppColor.dark),
//                       bodySmall: TextStyle(
//                           fontFamily: "Gilmer",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 12,
//                           color: AppColor.dark)),
//                   // Customize other dark theme properties here
//                 ),
//           child: child!,
//         );
//       },
//     );
//     if (pickedDate != null && pickedDate != _selectedDate) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//       _saveDateTimeToFirestore();
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime,
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: Theme.of(context).brightness == Brightness.light
//               ? ThemeData.light().copyWith(
//                   colorScheme: ColorScheme.light(
//                     primary: Theme.of(context).colorScheme.tertiary,
//                     onPrimary: Theme.of(context).colorScheme.onBackground,
//                   ),
//                   textTheme: const TextTheme(
//                       bodyLarge: TextStyle(
//                           fontFamily: "Gilmer",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16,
//                           color: AppColor.dark),
//                       bodyMedium: TextStyle(
//                           fontFamily: "Gilmer",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                           color: AppColor.dark),
//                       bodySmall: TextStyle(
//                           fontFamily: "Gilmer",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 12,
//                           color: AppColor.dark)),
//                   // Customize other light theme properties here
//                 )
//               : ThemeData.dark().copyWith(
//                   colorScheme: ColorScheme.dark(
//                     primary: Theme.of(context).colorScheme.tertiary,
//                     onPrimary: Theme.of(context).colorScheme.onBackground,
//                   ),
//                   textTheme: const TextTheme(
//                       bodyLarge: TextStyle(
//                           fontFamily: "Gilmer",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16,
//                           color: AppColor.dark),
//                       bodyMedium: TextStyle(
//                           fontFamily: "Gilmer",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                           color: AppColor.dark),
//                       bodySmall: TextStyle(
//                           fontFamily: "Gilmer",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 12,
//                           color: AppColor.dark)),
//                   // Customize other dark theme properties here
//                 ),
//           child: child!,
//         );
//       },
//     );
//   }

//   Duration _duration = Duration(); // Declare duration variable

//   Future<void> _durationPicker(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime,
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: Theme.of(context).brightness == Brightness.light
//               ? ThemeData.light().copyWith(
//                   colorScheme: ColorScheme.light(
//                     primary: Theme.of(context).colorScheme.tertiary,
//                     onPrimary: Theme.of(context).colorScheme.onBackground,
//                   ),
//                   textTheme: const TextTheme(
//                     bodyLarge: TextStyle(
//                       fontFamily: "Gilmer",
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                       color: AppColor.dark,
//                     ),
//                     bodyMedium: TextStyle(
//                       fontFamily: "Gilmer",
//                       fontWeight: FontWeight.w700,
//                       fontSize: 14,
//                       color: AppColor.dark,
//                     ),
//                     bodySmall: TextStyle(
//                       fontFamily: "Gilmer",
//                       fontWeight: FontWeight.w700,
//                       fontSize: 12,
//                       color: AppColor.dark,
//                     ),
//                   ),
//                   // Customize other light theme properties here
//                 )
//               : ThemeData.dark().copyWith(
//                   colorScheme: ColorScheme.dark(
//                     primary: Theme.of(context).colorScheme.tertiary,
//                     onPrimary: Theme.of(context).colorScheme.onBackground,
//                   ),
//                   textTheme: const TextTheme(
//                     bodyLarge: TextStyle(
//                       fontFamily: "Gilmer",
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                       color: AppColor.dark,
//                     ),
//                     bodyMedium: TextStyle(
//                       fontFamily: "Gilmer",
//                       fontWeight: FontWeight.w700,
//                       fontSize: 14,
//                       color: AppColor.dark,
//                     ),
//                     bodySmall: TextStyle(
//                       fontFamily: "Gilmer",
//                       fontWeight: FontWeight.w700,
//                       fontSize: 12,
//                       color: AppColor.dark,
//                     ),
//                   ),
//                   // Customize other dark theme properties here
//                 ),
//           child: child!,
//         );
//       },
//     );

//     if (pickedTime != null && pickedTime != _selectedTime) {
//       setState(() {
//         _selectedTime = pickedTime;
//         _duration = Duration(
//             hours: _selectedTime.hour,
//             minutes: _selectedTime
//                 .minute); // Calculate duration based on selected time
//       });
//       _saveDateTimeToFirestore();
//     }
//   }

//   Future<void> _saveDateTimeToFirestore() async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('selectedDateTime')
//           .doc('selectedDateTime')
//           .set({
//         'date': _selectedDate.toString(),
//         'time': _selectedTime.toString(),
//       });
//     } catch (e) {
//       print('Error saving date and time: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Date & Time Picker',
//         onClickedBack: () {},
//         onClickedHome: () {},
//       ),
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // Column(
//             //       crossAxisAlignment: CrossAxisAlignment.start,
//             //   children: [
//             //     Text(
//             //         'Selected Date',
//             //         style: TextStyle(
//             //             fontSize: 20,
//             //             color: Theme.of(context).colorScheme.onBackground),
//             //       ),
//             //     GestureDetector(
//             //       onTap: () => _selectDate(context),
//             //       child: Container(
//             //         width: 300,
//             //         decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(8),),

//             //         child: Padding(
//             //           padding: const EdgeInsets.all(8.0),
//             //           child: Text(
//             //             '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}' ?? 'YYYY-DD-MM',
//             //             style: TextStyle(
//             //                 fontSize: 20,
//             //                 color: Theme.of(context).hintColor),
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             FormText(text: 'Activity Name', controller: _activityController),
//             FormText(text: 'Activity Name', controller: _activityController),
//             // SizedBox(height: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 5.0),
//                   child: Text(
//                     'Selected Time',
//                     style: TextStyle(
//                         fontSize: 14,
//                         color: Theme.of(context).colorScheme.onBackground),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () => _selectTime(context),
//                   child: Container(
//                     width: 320,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.secondary,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0)
//                           .add(const EdgeInsets.only(top: 5)),
//                       child: Text(
//                         // '${_selectedTime.hour} : ${_selectedTime.minute}' ??
//                             'HH : MM',
//                         style: TextStyle(
//                             fontSize: 15, color: Theme.of(context).hintColor),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 5.0),
//                     child: Text(
//                       'Duration',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Theme.of(context).colorScheme.onBackground,
//                       ),
//                     ),
//                   ),
//             GestureDetector(
//   onTap: () => _selectTime(context),
//   child: Container(
//     width: 320,
//     height: 50,
//     decoration: BoxDecoration(
//       color: Theme.of(context).colorScheme.secondary,
//       borderRadius: BorderRadius.circular(5),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(12.0).add(const EdgeInsets.only(top: 5)),
//       child: _selectedTime.period != DayPeriod.morning && _selectedTime.period != DayPeriod.afternoon // Check if AM/PM is applicable
//           ? Text(
//               '${_selectedTime.hourOfPeriod} : ${_selectedTime.minute} ${_selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}' ?? 'HH : MM',
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Theme.of(context).hintColor,
//               ),
//             )
//           : Text(
//               '${_selectedTime.hour} : ${_selectedTime.minute}' ?? 'HH : MM',
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Theme.of(context).hintColor,
//               ),
//             ),
//     ),
//   ),
// ),

//                 ],
//               ),
//             ),

//             Spacer(flex: 1),
//             GestureDetector(
//               onTap: () {
//                 // '           Navigator.push(
//                 //                   context,
//                 //                   MaterialPageRoute(
//                 //                     builder: (context) => TimerScreen(
//                 //                       activity: '${_selectedTime.hour} : ${_selectedTime.minute}',
//                 //                       duration: _duration,
//                 //                       startTime: _startTime,
//                 //                     ),
//                 //                   ),
//                 //                 );'
//               },
//               child: Container(
//                 width: 300,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.tertiary,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                     child: Text(
//                       'Set Timer',
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: Theme.of(context).colorScheme.background),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
