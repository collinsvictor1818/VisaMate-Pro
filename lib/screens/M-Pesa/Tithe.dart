// import 'package:visamate/page/M-Pesa/PaymentSuccessful.dart';
// import 'package:flutter/material.dart';

// import '../../component/Form/FormText.dart';
// import '../../page/Dashboard/M-Pesa.dart';
// import 'logic/paybill.dart';

// class Tithe extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => Visatate();
// }

// class Visatate extends State<Tithe> {
//   final _formKey = GlobalKey<FormState>();
//   String _businessShortCode = "795194";
//   late String _passKey;
//   late String _amount;
//   late String _phoneNumber;
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context)
//                   .push(MaterialPageRoute(builder: ((context) => MPesa())));
//             },
//             icon: Icon(Icons.arrow_back_ios_rounded),
//             color: Theme.of(context).colorScheme.tertiary),
//       ),
//       backgroundColor: Theme.of(context).colorScheme.secondary,
//       body: Padding(
//         padding: EdgeInsets.symmetric(vertical: 0),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             /**/ Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Text(
//                 "Pay Tithe",
//                 style: TextStyle(
//                     fontFamily: 'Gilmer',
//                     color: Theme.of(context).colorScheme.tertiary,
//                     fontSize: 35,
//                     fontWeight: FontWeight.w800),
//               ),
//             ),
//             Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.all(10),
//                   child: PhysicalModel(
//                     color: Theme.of(context).colorScheme.background,
//                     borderRadius: BorderRadius.circular(15),
//                     child: Container(
//                       height: 240,
//                       width: 300,
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Image.asset("assets/MPesaLogo.png",
//                                       height: 100),
//                                   Spacer(),
//                                   Column(
//                                     children: [
//                                       Text(
//                                         "Paybill",
//                                         style: TextStyle(
//                                           color: Theme.of(context).colorScheme.onBackground,
//                                           fontFamily: 'Gilmer',
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                       Text(
//                                         "795194",
//                                         style: TextStyle(
//                                           color: Theme.of(context).colorScheme.onBackground,
//                                           fontFamily: 'Gilmer',
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               FormText(
//                                 text: 'Amount',
                             
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             GestureDetector(
//               // onTap: () {
//               //   if (_formKey.currentState!.validate()) {
//               //     _formKey.currentState?.save();
//               //     makePayBillPayment(
//               //         _businessShortCode, _passKey, _amount, _phoneNumber);
//               //   }
//               // },
//                 onTap: (() {
//                     Navigator.of(context).push(MaterialPageRoute(builder: ((context) => paymentSuccessful())));
//                   }),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: GestureDetector(
//                   onTap: (() {
//                     Navigator.of(context).push(MaterialPageRoute(builder: ((context) => paymentSuccessful())));
//                   }),child: Container(
//                     height: 50,
//                     width: 300,
//                     child: PhysicalModel(
//                       color: Theme.of(context).colorScheme.tertiary,
//                       borderRadius: BorderRadius.circular(15),
//                       child: Center(
//                         child: Text(
//                           "Pay",
//                           style: TextStyle(
//                             color: Theme.of(context).colorScheme.onBackground,
//                             fontFamily: 'Gilmer',
//                             fontSize: 18,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "GOD BLESS YOU AS YOU GIVE",
//               style: TextStyle(
//                 color: Theme.of(context).colorScheme.secondary,
//                 fontFamily: 'Gilmer',
//                 fontSize: 15,
//                 fontWeight: FontWeight.w700,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
