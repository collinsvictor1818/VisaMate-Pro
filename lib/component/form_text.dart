import 'package:flutter/material.dart';

class FormText extends StatefulWidget {
  final String text;
  final String? hint;
  final TextEditingController? controller;
  final IconData? prefix;
  // final List<TextInputFormatter>? formatters;
  final List? formatters;
  final String? desc;
  final IconData? suffix;
  final BadgeThemeData? suggestion;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onClicked;
  final String? label;
  final TextInputType? keyboardType;

  const FormText({
    this.suggestion,
    required this.text,
    this.hint,
    this.desc,
    this.onChanged,
    this.formatters,
    this.controller,
    this.prefix,
    this.suffix,
    this.validator,
    this.onClicked,
    this.label,
    this.keyboardType,
    // required String title,
  });

  @override
  State<FormText> createState() => _FormTextState();
}

class _FormTextState extends State<FormText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
// Text(widget.text!,
//               textAlign: TextAlign.start,
//               style: TextStyle(
//                   color: Theme.of(context).colorScheme.onBackground,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: 'Gilmer',
//                   fontSize: 18)),        // Padding(padding: EdgeInsets.symmetric(vertical: 3)),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5.0),
//             child: Text(
//               widget.desc??'',
//               textAlign: TextAlign.start,
//               style: TextStyle(
//                   color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
//                   fontWeight: FontWeight.w700,
//                   fontFamily: 'Gilmer',
//                   fontSize: 12),
//             ),
//           ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  style: TextStyle(
                    fontFamily: 'Gilmer',
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w700,
                  ),
                  // inputFormatters: ,
                  enableSuggestions: true,
                  keyboardType: TextInputType.text,
                  controller: widget.controller,
                  validator: widget.validator,
                  onChanged: widget.onChanged,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: InputDecoration(
                    focusColor: Theme.of(context).colorScheme.tertiary,
                    border: InputBorder.none,
                    prefixIcon: Icon(widget.prefix,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 16),
                    fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 0),
                    ),
                    hintText: widget.text,
                    hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        fontFamily: "Gilmer",
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).hintColor),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Padding(padding: EdgeInsets.symmetric(vertical: 7)),
      ],
    );
  }
}
