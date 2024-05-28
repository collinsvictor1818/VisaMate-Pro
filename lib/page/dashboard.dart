// import 'package:visamate/component/cards/updates&events.dart';
// import 'package:visamate/utils/responsive/responsive.dart';
// import 'package:flutter/material.dart';
// import 'package:visamate/component/appbars/appBarActionItems.dart';
// import 'package:visamate/component/appbars/header.dart';
// import 'package:showcaseview/showcaseview.dart';
// import '../component/appbars/BottomNav.dart';
// import '../component/bottom_menu.dart';
// import '../component/cards/my_tile.dart';
// import '../component/drawer.dart';
// import '../utils/responsive/size_config.dart';
// import 'package:visamate/component/cards/infoCard.dart';

// // ignore: must_be_immutable
// class Dashboard extends StatefulWidget {
//   final String? username; // Add this line

//   const Dashboard({
//     this.username, // Add this line
//   });
//   @override
//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

//   // ignore: unused_field
//   int _currentIndex = 0;
//   bool loading = true;
//   Widget? loadingWidget;
//   final GlobalKey _myTasksKey = GlobalKey();
//   final GlobalKey _myStatusKey = GlobalKey();
//   final GlobalKey _farmSetupKey = GlobalKey();
//   final GlobalKey _consultationKey = GlobalKey();
//   final GlobalKey _transactionsKey = GlobalKey();
//   final GlobalKey _newsFeedKey = GlobalKey();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final scrollController = ScrollController();
//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Future.delayed(const Duration(seconds: 3), () {
//         setState(() {
//           loading = false;
//         });
//       });
//     });
//   }

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
//                       _drawerKey.currentState!.openDrawer();
//                     },
//                     icon: Icon(
//                       Icons.menu,
//                       size: 27,
//                       color: Theme.of(context).colorScheme.tertiary,
//                     )),
//                 actions: [
//                   const AppBarActionItems(),
//                 ],
//               )
//             : const PreferredSize(
//                 preferredSize: Size.zero,
//                 child: SizedBox(),
//               ),
//         body: SafeArea(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (Responsive.isDesktop(context))
//                 const Expanded(
//                   flex: 1,
//                   child: IconMenu(),
//                 ),
//               Expanded(
//                   flex: 10,
//                   child: SafeArea(
//                     child: SingleChildScrollView(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: SizeConfig.screenWidth,
//                             child: Wrap(
//                               spacing: 20,
//                               runSpacing: 20,
//                               alignment: WrapAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Header(),
//                                 ),
//                                 InfoCard(
//                                     image: 'assets/People.png',
//                                     // cardColor: Color.fromARGB(28, 25, 51, 51),
//                                     label: 'Total \nMembers',
//                                     number: '\56,479',
//                                     onClicked: () {
//                                       Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                               builder: ((context) =>
//                                                   Dashboard())));
//                                     }),
//                                 InfoCard(
//                                     image: 'assets/Church.png',
//                                     label: 'Registered \nChurches',
//                                     //  cardColor: Color.fromARGB(7, 149, 193, 61),
//                                     number: '\21',
//                                     onClicked: () {
//                                       Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                               builder: ((context) =>
//                                                   Dashboard())));
//                                     }),
//                                 InfoCard(
//                                     image: 'assets/Group.png',
//                                     label: 'Harvest \nGroups',
//                                     //  cardColor: AppColor.blueSubtleHK,
//                                     number: '\147',
//                                     onClicked: () {
//                                       Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                               builder: ((context) =>
//                                                   Dashboard())));
//                                     }),
//                                 InfoCard(
//                                     image: 'assets/Zone.png',
//                                     // cardColor: AppColor.redSubtleHK,
//                                     label: 'Zones \n ',
//                                     number: '\57',
//                                     onClicked: () {
//                                       Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                               builder: ((context) =>
//                                                   Dashboard())));
//                                     }),
//                                 SizedBox(
//                                   height: 220,
//                                   child: ListView.builder(
//                                     itemCount: 4,
//                                     itemBuilder: (context, index) {
//                                       if (index == 0) {
//                                         return Showcase(
//                                           key: _farmSetupKey,
//                                           title: 'Farm Setup',
//                                           description:
//                                               'Explore the latest news here!',
//                                           child: MyTile(
//                                             title: 'Farm Setup',
//                                             action: () {
//                                               final snackBarHelper =
//                                                   SnackBarHelper(context);
//                                               snackBarHelper
//                                                   .showCustomSnackBarWithMenu();
//                                             },
//                                           ),
//                                         );
//                                       } else if (index == 1) {
//                                         return Showcase(
//                                           key: _consultationKey,
//                                           title: 'Consultation Services',
//                                           description:
//                                               'Explore the latest news here!',
//                                           child: MyTile(
//                                               title: 'Consultation Services'),
//                                         );
//                                       } else if (index == 2) {
//                                         return Showcase(
//                                           key: _transactionsKey,
//                                           title: 'Billings & Transactions',
//                                           description:
//                                               'Explore the latest news here!',
//                                           child: const MyTile(
//                                               title: 'Billings & Transactions'),
//                                         );
//                                       } else {
//                                         return const SizedBox.shrink();
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: SizeConfig.blockSizeVertical! * 4,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomNav());
//   }
// }
