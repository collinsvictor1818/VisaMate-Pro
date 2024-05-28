// import 'package:visamate/utils/responsive/responsive_layout.dart';
// import 'package:flutter/material.dart';
// import '../../page/dashboard.dart';
// import '../../styles/pallete.dart';
// import '../../utils/responsive/desktop_body.dart';
// import '../../utils/responsive/mobile_body.dart';
// import '../../utils/responsive/tablet_body.dart';

// class NavBar extends StatelessWidget {
//   final int? currentIndex;
//   Function(int)? onTap;

//   NavBar({this.currentIndex,  this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return PhysicalModel(
//       clipBehavior: Clip.none,
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(15),
//       child: Container(
//         decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, ),
//         height: 70,
//         child: Center(
//             child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             BM(
//                 title: 'Register\nMember',
//                 onClick:  () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: ((context) => const ResponsiveLayout(mobileBody: MobileScaffold(),tabletBody: TabletScaffold(), desktopBody: DesktopScaffold(),))));
//                     },
//                 icon: Icons.add_circle),
//             BM(
//                 title: 'Attendance\nReport',
//                 onClick:  () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: ((context) => const ResponsiveLayout(mobileBody: MobileScaffold(),tabletBody: TabletScaffold(), desktopBody: DesktopScaffold(),))));
//                     },
//                 icon: Icons.view_comfortable),
//             BM(
//                 title: 'Home',
//                 onClick:  () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: ((context) => const ResponsiveLayout(mobileBody: MobileScaffold(),tabletBody: TabletScaffold(), desktopBody: DesktopScaffold(),))));
//                     },
//                 icon: Icons.home_filled),
//             BM(
//                 title: 'Home',
//                 onClick: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: ((context) => const ResponsiveLayout(mobileBody: MobileScaffold(),tabletBody: TabletScaffold(), desktopBody: DesktopScaffold(),))));
//                     },
//                 icon: Icons.person),
//             BM(
//                 title: 'Settings',
//                 onClick:  () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: ((context) => const ResponsiveLayout(mobileBody: MobileScaffold(),tabletBody: TabletScaffold(), desktopBody: DesktopScaffold(),))));
//                     },
//                 icon: Icons.settings),
//           ],
//         )),
//       ),
//     );
//   }

//   Widget BM({String? title, VoidCallback? onClick, IconData? icon}) {
//     return Builder(builder: (context) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0).add(EdgeInsets.only(bottom: 10)),
//         child: GestureDetector(
//           onTap: onClick,
//           child: Container(
//             child: Column(
//               children: [
//                 Icon(icon, size: 35),
//                 Text(
//                   '',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: AppColor.accentDark,
//                       fontFamily: 'Gilmer',
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
