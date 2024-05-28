  
// import 'package:visamate/component/appbars/CustomAppBar.dart';
// import '../../../styles/pallete.dart';
// import 'dashboard.dart';


// Widget build(BuildContext context) => MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Setup',
//       color: Theme.of(context).colorScheme.background,
//       theme: ThemeData(
//           primarySwatch: Theme.of(context).colorScheme.tertiary, scaffoldBackgroundColor: Colors.white),
//       home: Admin(),
//     );

// class Admin extends StatefulWidget {
//   @override
//   State<Admin> createState() => _AdminState();
// }

// class _AdminState extends State<Admin> {
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: CustomAppBar(
//           title: "Admin",
//           onClickedHome: () {
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (context) => Dashboard()));
//           },
//           onClickedBack: () {
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (context) => IconMenu()));
//           }),
//       body: ListView(shrinkWrap: true, children: <Widget>[
//         Padding(padding: EdgeInsets.symmetric(vertical: 5)),
//         BuildList(
//           icon: Icons.data_saver_off_sharp,
//           title: " Adjust Reports" ?? 'default',
//           desc: "Brief Description",
//           onClicked: () => Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => adjustReports(),
//           )),
//         ),
//         BuildList(
//           title: "Admin Report" ?? 'default',
//           icon: Icons.data_object_sharp,
//           // onClicked: () => Navigator.of(context).push(MaterialPageRoute(
//           //   builder: (context) => adminReports(),
//           // )),
//         ),
//       ]),
//     );
//   }
// }
