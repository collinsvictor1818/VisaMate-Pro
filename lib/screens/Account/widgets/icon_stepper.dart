// import 'package:flutter/material.dart';

// class IconStepper extends StatelessWidget {
//   const IconStepper();

//   @override
//   Widget build(BuildContext context) {
//     return IconStepper(
//                                 icons: [
//                                   Icon(
//                                     Icons.person,
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onBackground,
//                                   ),
//                                   Icon(Icons.phone,
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .onBackground),
//                                   Icon(Icons.password,
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .onBackground)
//                                 ],
//                                 scrollingDisabled: true,
//                                 steppingEnabled: false,
//                                 enableStepTapping: false,
//                                 lineLength: 25,
//                                 stepRadius: 1,
//                                 stepPadding: 0.0,

//                                 // numbers: const [1, 2, 3] ,
//                                 lineColor:
//                                     Theme.of(context).colorScheme.tertiary,
//                                 activeStepColor:
//                                     Theme.of(context).colorScheme.tertiary,
//                                 activeStepBorderColor:
//                                     Theme.of(context).colorScheme.tertiary,
//                                 stepColor: Theme.of(context)
//                                     .colorScheme
//                                     .tertiary
//                                     .withOpacity(.15),
//                                 activeStep: activeStep,
//                                 onStepReached: (index) {
//                                   setState(() {
//                                     activeStep = index;
//                                   });
//                                 },
//                               ),;
//   }
// }