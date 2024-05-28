// import 'package:flutter/material.dart';
// import '../../styles/pallete.dart';



// class StepperWidget extends StatefulWidget {
//   final String title;
//   final int level;
//   final Widget content;

//   const StepperWidget({
//     Key? key,
//     required this.title,
//     required this.content,
//     required this.level,
//   }) : super(key: key);

//   @override
//   _StepperWidgetState createState() => _StepperWidgetState();
// }

// class _StepperWidgetState extends State<StepperWidget> {
//   int activeStep = 0; // Initial step set to 0.
//   int dotCount = 5;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('DotStepper Example'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Builder(builder: (context) {
//                 return Align(
//                   alignment: Alignment.centerLeft,
//                   child: Stepper(
//                     currentStep: activeStep,
//                     onStepContinue: continueStep,
//                     onStepCancel: cancelStep,
//                     onStepTapped: tappedStep,
//                     controlsBuilder: controlBuilder,
//                     steps: [
//                       Step(
//                         title: Text(
//                           widget.title,
//                           textAlign: TextAlign.start,
//                           textDirection: TextDirection.ltr,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Theme.of(context).colorScheme.secondary,
//                             fontFamily: "Gilmer",
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         content: widget.content,
//                         isActive: activeStep >= widget.level,
//                         state: activeStep >= widget.level
//                             ? StepState.complete
//                             : StepState.disabled,
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   int currentStep = 0; // Initial step set to 0.

//   continueStep() {
//     if (activeStep < 2) {
//       setState(() {
//         activeStep = activeStep + 1;
//       });
//     }
//   }

//   cancelStep() {
//     if (activeStep > 0) {
//       setState(() {
//         activeStep = activeStep - 1;
//       });
//     }
//   }

//   tappedStep(int value) {
//     setState(() {
//       activeStep = value;
//     });
//   }

//   Widget controlBuilder(context, details, {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
//     return Row(
//       children: [
//         ElevatedButton(onPressed: onStepContinue, child: Text('Next')),
//         SizedBox(
//           width: 5,
//         ),
//         OutlinedButton(onPressed: onStepCancel, child: Text('Back')),
//       ],
//     );
//   }
// }
