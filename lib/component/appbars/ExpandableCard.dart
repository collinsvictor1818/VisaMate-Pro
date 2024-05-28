
// import 'package:flutter/material.dart';
// import '../../styles/pallete.dart';

// class expandableCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       theme: new ThemeData(primaryColor: Theme.of(context).colorScheme.background),
//     );
//   }
// }


// Widget ExpandableCard({
//   String? title,
//   String? subtitle,
//   String? content,
//   VoidCallback? onClick,
// }) {
//   return PhysicalModel(
//       color: Theme.of(context).colorScheme.secondary,
//       child: Center(
//         child: ExpansionCard(
//           borderRadius: 20,
//           //background:
//           title: Container(
//             child: ListTile(
//               title: Transform.translate(
//                   offset: Offset(-20, 0),
//                   child: Text(
//                     title ?? '',
//                     style: TextStyle(
//                         fontFamily: "Gilmer",
//                         fontSize: 30,
//                         color: AppColor.accentDark),
//                   )),
//               subtitle: Transform.translate(
//                   offset: Offset(-20, 0),
//                   child: Text(
//                     subtitle ?? '',
//                     style: TextStyle(
//                         fontFamily: "Gilmer",
//                         fontSize: 30,
//                         color: AppColor.accentDark),
//                   )),
//             ),
//           ),
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 7),
//               child: Text(
//                 content ?? '',
//                 style: TextStyle(
//                     fontFamily: "Gilmer",
//                     fontSize: 20,
//                     color: AppColor.accentDark),
//               ),
//             )
//           ],
//         ),
//       ));
// }

// // 