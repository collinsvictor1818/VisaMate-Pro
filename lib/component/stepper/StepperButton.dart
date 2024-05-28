import 'package:flutter/material.dart';

class Stepper extends StatefulWidget {
 final String text;
  final String content;

  final TextEditingController controller;
  final IconData prefix;
  final IconData suffix;
  final VoidCallback onClicked;
  final String label;

  const Stepper({
    required Key key,
    required this.text,
    required this.content,
    required this.controller,
    required this.prefix,
    required this.suffix,
    required this.onClicked,
    required this.label, required List<Step> steps,
  }) : super(key: key);

  @override
  State<Stepper> createState() => _StepperState();
}

class _StepperState extends State<Stepper> {
  // REQUIRED: USED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 0.

  // OPTIONAL: can be set directly.
  int dotCount = 5;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      
        Padding(padding: EdgeInsets.symmetric(vertical: 3)),

        /// Button
        ///
      
        ///
        Padding(padding: EdgeInsets.symmetric(vertical: 7)),
      ],
    );
  }

  Row steps() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(dotCount, (index) {
        return ElevatedButton(
          child: Text('${index + 1}'),
          onPressed: () {
            setState(() {
              activeStep = index;
            });
          },
        );
      }),
    );
  }

  /// Returns the next button widget.
  Widget nextButton() {
    return ElevatedButton(
      child: Text('Next'),
      onPressed: () {
        /// ACTIVE STEP MUST BE CHECKED FOR (dotCount - 1) AND NOT FOR dotCount To PREVENT Overflow ERROR.
        if (activeStep < dotCount - 1) {
          setState(() {
            activeStep++;
          });
        }
      },
    );
  }

  /// Returns the previous button widget.
  Widget previousButton() {
    return ElevatedButton(
      child: Text('Prev'),
      onPressed: () {
        // activeStep MUST BE GREATER THAN 0 TO PREVENT OVERFLOW.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
    );
  }
}
