// import 'package:flutter/material.dart';
// import 'package:visamate/component/appbars/CustomAppBar.dart';
// import 'package:visamate/page/dashboard.dart';
// import '../component/appbars/BottomNav.dart';
// import '../component/listview/ListBuilder.dart';


// Widget build(BuildContext context) {
//   return MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Settings',
//     theme: ThemeData(
//       primarySwatch: Theme.of(context).colorScheme.tertiary,
//     ),
//     home: Settings(),
//   );
// }

// class Settings extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => StartState();
// }

// class StartState extends State<Settings> {
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Theme.of(context).colorScheme.background,
//         appBar: CustomAppBar(
//           title: "Settings",
//           onClickedHome: () {
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: ((context) => Dashboard())));
//           }, onClickedBack: () {  },
//         ),
//         body: ListView(children: <Widget>[
//           Padding(padding: EdgeInsets.symmetric(vertical: 5)),
//           BuildList(
//             icon: Icons.data_saver_off_sharp,
//             title: "Data Sheet Master",
//             desc: "Under Development",
//             onClicked: () => Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => Dashboard(),
//             )),
//           ),
//           BuildList(
//             icon: Icons.people_alt_rounded,
//             title: "Attendance",
//             desc: "Not Ready",
//             onClicked: () => Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => Dashboard(),
//             )),
//           ),
//           /*
//           BuildList(
//           icon: Icons.person_pin_circle,
//           title: "Attendance Report",
//           desc: "Brief Description",
//           onClicked: () => Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => attendanceReport(),
//           )),
//           ),
//           BuildList(
//             icon: Icons.person_pin_circle,
//             title: "Visitation Report",
//             desc: "Brief Description",
//             onClicked: () => Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => visitationReport(),
//             )),
//           ),
//           BuildList(
//             icon: Icons.person_pin_circle,
//             title: "Test components",
//             desc: "Brief Description",
//             onClicked: () => Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => Testcomponents(),
//             )),
//           ),*/
//         ]),
//        bottomNavigationBar: BottomNav());
//   }
// }
