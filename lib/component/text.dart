import 'package:flutter/material.dart';

class Jina extends StatefulWidget {
  final String text;
  final Color rangi;

  const Jina({
    
    required this.text,
    required this.rangi,
  });

  @override
  State<Jina> createState() => _JinaState();
}

class Subtitle extends StatelessWidget {
  final String? text;
  final String? hint;
  const Subtitle({ this.hint, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0)
          .add(const EdgeInsets.only(top: 8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(text!,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilmer',
                  fontSize: 18)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              hint!,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilmer',
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
  
}

class _JinaState extends State<Jina> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontFamily: "Gilmer",
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: widget.rangi, // Set the text color here
      ),
    );
  }
}
