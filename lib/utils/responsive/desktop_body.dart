// import 'package:visamate/component/appbars/config/responsive.dart';
// import 'package:visamate/component/bottom_menu.dart';
// import 'package:visamate/utils/responsive/mobile_body.dart';
// import 'package:flutter/material.dart';
// import 'package:visamate/component/drawer.dart';
// import 'package:showcaseview/showcaseview.dart';

// import '../../component/appbars/config/size_config.dart';
// import '../../component/appbars/header.dart';
// import '../../component/cards/infoCard.dart';
// import '../../component/cards/my_box.dart';
// import '../../component/cards/my_tile.dart';
// import '../../component/cards/updates&events.dart';
// import '../../page/Dashboard/People.dart';
// import 'package:visamate/component/cards/updates&events.dart';
// import 'package:visamate/page/Dashboard/M-Pesa.dart';
// import 'package:flutter/material.dart';
// import 'package:visamate/component/appbars/appBarActionItems.dart';
// import 'package:visamate/component/appbars/header.dart';
// import 'package:provider/provider.dart';
// import 'package:showcaseview/showcaseview.dart';
// import 'package:visamate/component/cards/infoCard.dart';
// import '../../component/appbars/BottomNav.dart';
// import '../../component/appbars/config/size_config.dart';
// import '../../component/bottom_menu.dart';
// import '../../component/drawer.dart';
// import '../../page/Dashboard/People.dart';
// import '../../component/cards/my_tile.dart';
// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// import 'package:showcaseview/showcaseview.dart';
// import 'package:xml/xml.dart' as xml;
// import 'package:html/parser.dart' as htmlParser;
// import 'package:url_launcher/url_launcher.dart';


// class DesktopScaffold extends StatefulWidget {


//   const DesktopScaffold();
//   @override
//   State<DesktopScaffold> createState() => _DesktopScaffoldState();
// }

// class _DesktopScaffoldState extends State<DesktopScaffold> {
//   GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
//   final GlobalKey _peopleKey = GlobalKey();
//   final GlobalKey _groupKey = GlobalKey();
//   final GlobalKey _scheduleKey = GlobalKey();
//   final GlobalKey _childKey = GlobalKey();
//   final GlobalKey _payKey = GlobalKey();
//   final GlobalKey _newsFeedKey = GlobalKey();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final scrollController = ScrollController();
//   // ignore: unused_field
//   int _currentIndex = 0;
//   bool loading = true;
//   Widget? loadingWidget;


//   Future<Map<String, int>> tally() async {
//     try {
//       final QuerySnapshot groupQuery = await FirebaseFirestore.instance
//           .collection('groups')
//           .where('abbreviation', isEqualTo: 'HFC')
//           .get();

//       String groupDocId = groupQuery.docs.first.id;
//       final QuerySnapshot groupSnapshot =
//           await FirebaseFirestore.instance.collection('groups').get();
//       final QuerySnapshot branchSnapshot = await FirebaseFirestore.instance
//           .collection('groups')
//           .doc(groupDocId)
//           .collection('branches')
//           .get();
//       final QuerySnapshot memberSnapshot =
//           await FirebaseFirestore.instance.collection('members').get();
//       int groupCount = groupSnapshot.size;
//       int branchCount = branchSnapshot.size;
//       int memberCount = memberSnapshot.size;
//       return {
//         'groups': groupCount,
//         'branches': branchCount,
//         'members': memberCount,
//         // Add more details here if needed
//       };
//     } catch (e) {
//       print(e);
//       return {
//         'groups': 0,
//         'branches': 0,
//         // Initialize other details with 0 in case of an error
//       };
//     }
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

//   final _controller = ScrollController();



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _drawerKey,
//       backgroundColor: Theme.of(context).colorScheme.background,
//       // appBar: myAppBar, 
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // open drawer
//             const IconMenu(),
//             // first half of page
//             SizedBox(
//               width: 1200,
//               child: Center(
//                 child: SizedBox(
//                   width: 600,
//                   child: SafeArea(
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
//                               direction: Axis.horizontal,
//                               alignment: WrapAlignment.spaceBetween,
//                               spacing: 20.0,
//                               runAlignment: WrapAlignment.start,
//                               runSpacing: 20.0,
//                               crossAxisAlignment: WrapCrossAlignment.start,
//                               children: [
//                                 Padding(
//                                   key:
//                                       UniqueKey(), // Assign a unique key to this child
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Header(
//                                     username: "User",
//                                   ),
//                                 ),
//                                 FutureBuilder<Map<String, int>>(
//                                   future:
//                                       tally(), // Call the tally function to get data asynchronously
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return Center(
//                                           child: CircularProgressIndicator(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .tertiary));
//                                     } else if (snapshot.hasError) {
//                                       // Show an error message if data fetching fails
//                                       return Text('Error: ${snapshot.error}');
//                                     } else {
//                                       // Access the group count from the snapshot data
//                                       int memberCount =
//                                           snapshot.data!['members'] ?? 0;
                                
//                                       // Display the group count in the InfoCard
//                                       return InfoCard(  icon: Icons.travel_explore_rounded,
//                                         //image: 'assets/People.png',
//                                         label: 'Total\nMembers',
//                                         number: '$memberCount',
//                                         onClicked: () {
//                                           Navigator.of(context)
//                                               .push(MaterialPageRoute(
//                                             builder: ((context) =>
//                                                 MobileScaffold()),
//                                           ));
//                                         },
//                                         opFunction: () => tally(),
//                                       );
//                                     }
//                                   },
//                                 ),
//                                 FutureBuilder<Map<String, int>>(
//                                   future:
//                                       tally(), // Call the tally function to get data asynchronously
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       // Show a loading indicator while data is being fetched
//                                       return CircularProgressIndicator();
//                                     } else if (snapshot.hasError) {
//                                       // Show an error message if data fetching fails
//                                       return Text('Error: ${snapshot.error}');
//                                     } else {
//                                       // Access the group count from the snapshot data
//                                       int groupCount =
//                                           snapshot.data!['groups'] ?? 0;
                                
//                                       // Display the group count in the InfoCard
//                                       return InfoCard(  icon: Icons.travel_explore_rounded,
//                                         //image: 'assets/Church.png',
//                                         label: 'Registered \nChurches',
//                                         number: '$groupCount',
//                                         onClicked: () {
//                                           Navigator.of(context)
//                                               .push(MaterialPageRoute(
//                                             builder: ((context) =>
//                                                 MobileScaffold()),
//                                           ));
//                                         },
//                                         opFunction: () => tally(),
//                                       );
//                                     }
//                                   },
//                                 ),
//                                 InfoCard(  icon: Icons.travel_explore_rounded,
//                                     //image: 'assets/Group.png',
//                                     label: 'Harvest \nGroups',
//                                     //  cardColor: AppColor.blueSubtleHK,
//                                     number: '\0',
//                                     opFunction: () => tally(),
//                                     onClicked: () {
//                                       Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                               builder: ((context) =>
//                                                   MobileScaffold())));
//                                     }),
//                                 InfoCard(  icon: Icons.travel_explore_rounded,
//                                     //image: 'assets/Zone.png',
//                                     // cardColor: AppColor.redSubtleHK,
//                                     label: 'Zones \n ',
//                                     number: '\0',
//                                     opFunction: () => tally(),
//                                     onClicked: () {
//                                       Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                               builder: ((context) =>
//                                                   MobileScaffold())));
//                                     }),
//                                 SizedBox(
//                                   height: 210,
//                                   child: ListView.builder(
//                                     itemCount: 4,
//                                     itemBuilder: (context, index) {
//                                       if (index == 0) {
//                                         return MyTile(
//                                           title: 'Schedule Service',
//                                           action: () {
//                                             final snackBarHelper =
//                                                 SnackBarHelper(context);
//                                             snackBarHelper
//                                                 .showCustomSnackBarWithMenu();
//                                           },
//                                         );
//                                       } else if (index == 1) {
//                                         return MyTile(
//                                           title: 'View application Records',
//                                           action: () {
//                                             final snackBarHelper =
//                                                 Snacky(context);
//                                             snackBarHelper
//                                                 .showSundaySchoolOptions();
//                                           },
//                                         );
//                                       } else if (index == 2) {
//                                         return MyTile(
//                                           title: 'Apply for a Visa',
//                                           action: () {
//                                             final snackBarHelper =
//                                                 Mpesa(context);
//                                             snackBarHelper
//                                                 .showGivingOptions();
//                                           },
//                                         );
//                                       } else {
//                                         return const SizedBox.shrink();
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                             horizontal: 10.0)
//                                         .add(const EdgeInsets.symmetric(
//                                             vertical: 2)),
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           'Travel Recommendations',
//                                           style: TextStyle(
//                                             fontFamily: 'Gilmer',
//                                             fontSize: 14,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .onBackground,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                         const Spacer(flex: 1),
//                                         Text(
//                                           'More',
//                                           style: TextStyle(
//                                             fontFamily: 'Gilmer',
//                                             fontSize: 14,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .tertiary,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                         Icon(
//                                           Icons.arrow_forward_rounded,
//                                           size: 14,
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .tertiary,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 5.0),
//                                   child: Container(
//                                     height: 155,
//                                     child: ListView.builder(
//                                       itemCount: 5,
//                                       scrollDirection: Axis.horizontal,
//                                       itemBuilder: (context, index) {
//                                         return SizedBox(
//                                           width: 300,
//                                           child: Updates(),
//                                         );
//                                       },
//                                     ),
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
//         ),        ),
//               ),
//             ),
//             // second half of page
//             Expanded(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 400,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: Theme.of(context).colorScheme.secondary,
//                       ),
//                     ),
//                   ),
//                   // list of stuff
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: Theme.of(context).colorScheme.secondary,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
