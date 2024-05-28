import 'package:flutter/material.dart';
import '../../styles/pallete.dart';

class FormDropDown extends StatefulWidget {
  final String text;
  final TextEditingController? controller;
  final String? hint;
  final String? desc;
  final IconData? prefix;
  final List<String> list;
  final VoidCallback? onClicked;

  const FormDropDown({
    Key? key,
    required this.text,
    this.controller,
    this.hint,
    this.desc,
    this.prefix,
    required this.list,
    this.onClicked,
    String? label,
  }) : super(key: key);

  @override
  _FormDropDownState createState() => _FormDropDownState();
}

class _FormDropDownState extends State<FormDropDown> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
      children: [
     Text(widget.text!,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilmer',
                  fontSize: 18)),        // Padding(padding: EdgeInsets.symmetric(vertical: 3)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              widget.desc??'',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilmer',
                  fontSize: 12),
            ),
          ),
        DropdownButtonFormField<String>(
          itemHeight: 50,
          style: TextStyle(
            fontFamily: 'Gilmer',
            fontSize: 14,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w300,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: "   Select ${widget.text}",
            hintStyle: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
              fontFamily: "Gilmer",
              fontWeight: FontWeight.w700,
            ),
            suffixIcon: Icon(widget.prefix,
                        color: Theme.of(context).colorScheme.tertiary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.secondary,
            contentPadding:
                EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 10),
          ),
          isExpanded: true,
          iconSize: 30,
          iconEnabledColor: Theme.of(context).colorScheme.secondary,
          value: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
              widget.controller?.text = value!;
            });
            if (widget.onClicked != null) {
              widget.onClicked!();
            }
          },
          items: widget.list
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Gilmer",
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ))
              .toList(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a value';
            }
            return null;
          },
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 7)),
      ],
    );
  }
}
