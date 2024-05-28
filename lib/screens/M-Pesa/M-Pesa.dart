// import 'package:visamate/utils/responsive/responsive.dart';
// import 'package:flutter/material.dart';

// import '../../component/appbars/ActionCards.dart';
// import '../../component/appbars/BottomNav.dart';
// import '../../component/appbars/appBarActionItems.dart';
// import '../../component/drawer.dart';

// import '../../styles/style.dart';
// import '../../utils/responsive/size_config.dart';
// import '../M-Pesa/Building.dart';
// import '../M-Pesa/Travel.dart';
// import '../M-Pesa/Special.dart';
// import '../M-Pesa/Tithe.dart';

// // ignore: must_be_immutable
// class MPesa extends StatelessWidget {
//   GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//         key: _drawerKey,
//         backgroundColor: Theme.of(context).colorScheme.background,
//         drawer: SizedBox(width: 210, child: IconMenu()),
//         appBar: !Responsive.isDesktop(context)
//             ? AppBar(
//                 elevation: 0,
//                 backgroundColor: Theme.of(context).colorScheme.background,
//                 leading: IconButton(
//                     onPressed: () {
//                       _drawerKey.currentState?.openDrawer();
//                     },
//                     icon: Icon(Icons.menu, size: 27, color: Theme.of(context).colorScheme.tertiary)),
//                 actions: [
//                   AppBarActionItems(),
//                 ],
//               )
//             : PreferredSize(
//                 preferredSize: Size.zero,
//                 child: SizedBox(),
//               ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               PrimaryText(
//                   text: 'M-Pesa',
//                   size: 30,
//                   fontWeight: FontWeight.w800,
//                   color: Theme.of(context).colorScheme.onBackground),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical! * 2,
//               ),
//               SizedBox(
//                 width: SizeConfig.screenWidth,
//                 child: Wrap(
//                   spacing: 20,
//                   runSpacing: 20,
//                   alignment: WrapAlignment.spaceBetween,
//                   children: [
//                     ActionCard(
//                         image: 'assets/Cash.png',
//                         // cardColor: Color.fromARGB(28, 25, 51, 51),
//                         title: '  Tithe',
//                         onClicked: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: ((context) => Tithe())));
//                         }),
//                     ActionCard(
//                         image: 'assets/Cash.png',
//                         //  cardColor: Color.fromARGB(7, 149, 193, 61),
//                         title: '  Travel',
//                         onClicked: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: ((context) => Travel())));
//                         }),
//                     ActionCard(
//                         image: 'assets/Cash.png',
//                         //  cardColor: AppColor.blueSubtleHK,
//                         title: '  Building',
//                         onClicked: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: ((context) => Building())));
//                         }),
//                     ActionCard(
//                         image: 'assets/Cash.png',
//                         //  cardColor: AppColor.blueSubtleHK,
//                         title: '  Special',
//                         onClicked: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: ((context) => SpecialTravel())));
//                         }),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical! * 4,
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomNav());
//   }
// }
