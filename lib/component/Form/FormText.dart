import 'package:flutter/material.dart';
import '../../styles/pallete.dart';

class FormText extends StatefulWidget {
  final String text;
  final String? desc; 
  final String? hint;
  final TextEditingController? controller;
  final IconData? prefix;
  final IconData? suffix;
  final VoidCallback? onClicked;
  final String? label;

  const FormText({
    Key? key,
     required this.text,
   this.hint,
   this.desc,
    this.controller,
    this.prefix,
    this.suffix,
    this.onClicked,
    this.label,
  }) : super(key: key);

  @override
  State<FormText> createState() => _FormTextState();
}

class _FormTextState extends State<FormText> {
    
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
        const Padding(padding: EdgeInsets.symmetric(vertical: 1)),
        TextFormField(
          
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
            suffixIcon: Icon(widget.suffix, color:Theme.of(context).colorScheme.onBackground.withOpacity(0.7)),
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
        Padding(padding: EdgeInsets.symmetric(vertical: 7)),
      ],
    );
  }
}
