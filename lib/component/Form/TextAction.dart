import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../styles/pallete.dart';

import 'package:flutter/cupertino.dart';

class TimePicker extends StatefulWidget {
  final String text;
  final String? hint;
  final TextEditingController? controller;
  final IconData? prefix;
  final IconData? suffix;
  final VoidCallback? onClicked;
  final String? label;

  const TimePicker({
    Key? key,
    required this.text,
    this.hint,
    this.controller,
    this.prefix,
    this.suffix,
    this.onClicked,
    this.label,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final TextEditingController _activityController = TextEditingController();
  int _duration = 0;
  TimeOfDay _startTime = TimeOfDay.now();
  Widget _buildStartTimePicker(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime dateTime) {
          setState(() {
            _startTime = TimeOfDay.fromDateTime(dateTime);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.text,
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
              fontFamily: "Gilmer",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
        GestureDetector(
          onTap: widget.onClicked,
          child: TextFormField(
            maxLines: 3,
            controller: widget.controller,
            cursorColor: Theme.of(context).colorScheme.tertiary,
            minLines: 1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter ${widget.text}';
              }
              return null;
            },
            style: TextStyle(
              fontFamily: 'Gilmer',
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: "Enter ${widget.text}",
              hintStyle: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
                fontFamily: "Gilmer",
                fontWeight: FontWeight.w700,
              ),
              focusColor: Theme.of(context).colorScheme.secondary,
              suffixIcon: Icon(widget.suffix,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.7)),
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              fillColor: Theme.of(context).colorScheme.secondary,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 7)),
      ],
    );
  }
}

class DurationPicker extends StatefulWidget {
  final String text;
  final String? hint;
  final TextEditingController? controller;
  final IconData? prefix;
  final IconData? suffix;
  final VoidCallback? onClicked;
  final String? label;

  const DurationPicker({
    Key? key,
    required this.text,
    this.hint,
    this.controller,
    this.prefix,
    this.suffix,
    this.onClicked,
    this.label,
  }) : super(key: key);

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  final TextEditingController _activityController = TextEditingController();
  int _duration = 0;
  TimeOfDay _startTime = TimeOfDay.now();
  Widget _buildDurationPicker(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: _duration),
        onSelectedItemChanged: (value) {
          setState(() {
            _duration = value;
          });
        },
        itemExtent: 32,
        children: List.generate(121, (index) => Text('$index')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.text,
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
              fontFamily: "Gilmer",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
        GestureDetector(
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (_) => _buildDurationPicker(context),
            );
          },
          child: TextFormField(
            maxLines: 3,
            controller: widget.controller,
            cursorColor: Theme.of(context).colorScheme.tertiary,
            minLines: 1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter ${widget.text}';
              }
              return null;
            },
            style: TextStyle(
              fontFamily: 'Gilmer',
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: "Enter ${widget.text}",
              hintStyle: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
                fontFamily: "Gilmer",
                fontWeight: FontWeight.w700,
              ),
              focusColor: Theme.of(context).colorScheme.secondary,
              suffixIcon: Icon(widget.suffix,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.7)),
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              fillColor: Theme.of(context).colorScheme.secondary,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 7)),
      ],
    );
  }
}

class DatePicker extends StatefulWidget {
  final String text;
  final String? hint;
  final TextEditingController? controller;
  final IconData? prefix;
  final IconData? suffix;
  final VoidCallback? onClicked;
  final String? label;

  const DatePicker({
    Key? key,
    required this.text,
    this.hint,
    this.controller,
    this.prefix,
    this.suffix,
    this.onClicked,
    this.label,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.controller?.text =
            "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.text,
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
        InkWell(
          onTap: () => _selectDate(context),
          child: TextFormField(
            readOnly: true,
            controller: widget.controller,
            cursorColor: Theme.of(context).colorScheme.tertiary,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select ${widget.text}';
              }
              return null;
            },
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: widget.hint ?? 'Select ${widget.text}',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
                fontWeight: FontWeight.w700,
              ),
              suffixIcon: Icon(
                widget.suffix ?? Icons.calendar_today,
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.7),
              ),
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.secondary,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 7)),
      ],
    );
  }
}
