import 'package:flutter/material.dart';

import '../../styles/pallete.dart';

class TimeWidget extends StatefulWidget {
  const TimeWidget();

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  @override
  Widget build(BuildContext context) {
    return Container();
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
  }}