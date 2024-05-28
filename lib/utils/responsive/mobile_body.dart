import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:visamate/component/cards/updates&events.dart';
import 'package:visamate/utils/responsive/responsive.dart';
import 'package:flutter/material.dart';
import '../../component/bottom_menu.dart';
import '../../page/CostAnalysis/cost_analysis_tool.dart';
import '../../page/Map/visa_map.dart';
import '../../page/Visa/AllCountries.dart';
import '../components/overlay_button.dart';
import 'package:visamate/component/appbars/appBarActionItems.dart';
import 'package:visamate/component/appbars/header.dart';
import 'package:visamate/component/cards/infoCard.dart';
import '../../component/appbars/BottomNav.dart';
import '../../component/appbars/config/size_config.dart';
import '../../component/drawer.dart';
import '../../screens/Map/map_screen.dart';
import '../../component/cards/my_tile.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../page/Visa/set_up_profile.dart';

// ignore: must_be_immutable
class MobileScaffold extends StatefulWidget {
  final String? username; // Add this line
  final String? selectedGroup;
  const MobileScaffold(
      {this.username, // Add this line
      this.selectedGroup});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  final TooltipController _controller = TooltipController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  // ignore: unused_field
  int _currentIndex = 0;
  bool loading = true;
  Widget? loadingWidget;
  bool done = false;
  bool _isLoggingIn = false;
  final _prefs = SharedPreferences.getInstance();
  Future _loadUserDataFromPrefs() async {
    final prefs = await _prefs;
    final String? usernamePrefs = prefs.getString('username');
    final String? firstNamePrefs = prefs.getString('first_name');
    final String? lastNamePrefs = prefs.getString('last_name');
    final String? phoneNumberPrefs = prefs.getString('phone');
    final String? emailPrefs = prefs.getString('email');
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<Map<String, int>> tally() async {
    try {
      final QuerySnapshot groupQuery = await FirebaseFirestore.instance
          .collection('groups')
          .where('abbreviation', isEqualTo: 'HFC')
          .get();

      String groupDocId = groupQuery.docs.first.id;
      final QuerySnapshot groupSnapshot =
          await FirebaseFirestore.instance.collection('groups').get();
      final QuerySnapshot branchSnapshot = await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupDocId)
          .collection('branches')
          .get();
      final QuerySnapshot memberSnapshot =
          await FirebaseFirestore.instance.collection('members').get();
      int groupCount = groupSnapshot.size;
      int branchCount = branchSnapshot.size;
      int memberCount = memberSnapshot.size;
      return {
        'groups': groupCount,
        'branches': branchCount,
        'members': memberCount,
        // Add more details here if needed
      };
    } catch (e) {
      print(e);
      return {
        'groups': 0,
        'branches': 0,
        // Initialize other details with 0 in case of an error
      };
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          loading = false;
        });
      });
    });
  }

  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return PopScope(
        // Handle back button press
        canPop: false,
        onPopInvoked: (_isLoggingIn) async {
          if (_isLoggingIn) {
            final confirmed = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Exit App'),
                // icon: Icon(Icons.dangerous_outlined, color: Theme.of(context).colorScheme.tertiary,),
                content: const Text('Are you sure you want to sign out?'),
                actions: [
                  Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                          padding: EdgeInsets.all(4),
                          child: TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontFamily: 'Gilmer',
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                          ))),
                  Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: TextButton(
                          // onPressed: () => Navigator.pop(context, true),
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(builder) => const LogInUser());
                          },
                          child: Text('Sign Out',
                              style: TextStyle(
                                  fontFamily: 'Gilmer',
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground)),
                        ),
                      )),
                ],
              ),
            );
          }
        },
        child: OverlayTooltipScaffold(
            // overlayColor: Colors.red.withOpacity(.4),
            tooltipAnimationCurve: Curves.linear,
            tooltipAnimationDuration: const Duration(milliseconds: 1000),
            controller: _controller,
            startWhen: (initializedWidgetLength) async {
              await Future.delayed(const Duration(milliseconds: 500));
              return initializedWidgetLength == 5 &&
                  !done; // Check if user has not interacted before
            },
            preferredOverlay: GestureDetector(
              onTap: () {
                _controller.dismiss();
                //move the overlay forward or backwards, or dismiss the overlay
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.6),
                  border: Border.all(
                    // color: Theme.of(context).colorScheme.tertiary, // Specify the color of the border
                    width: 1, // Specify the width of the border
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  // blendMode: BlendMode.multiply,
                  child: Container(
                      // color:  Theme.of(context).colorScheme.tertiary.withOpacity(0.5), // Specify the color of the border

                      ),
                ),
              ),
            ),
            builder: (context) => Scaffold(
                // key: _drawerKey,
                backgroundColor: Theme.of(context).colorScheme.background,
                key: _drawerKey,
                drawer: SizedBox(width: 260, child: IconMenu()),
                appBar: !Responsive.isDesktop(context)
                    ? AppBar(
                        elevation: 0,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        leading: IconButton(
                          onPressed: () {
                            _drawerKey.currentState?.openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            size: 27,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        actions: [
                          const AppBarActionItems(),
                        ],
                      )
                    : const PreferredSize(
                        preferredSize: Size.zero,
                        child: SizedBox(),
                      ),
                body: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (Responsive.isDesktop(context))
                        const Expanded(
                          flex: 1,
                          child: IconMenu(),
                        ),
                      Expanded(
                          flex: 10,
                          child: SafeArea(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.screenWidth,
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      alignment: WrapAlignment.spaceBetween,
                                      spacing: 20.0,
                                      runAlignment: WrapAlignment.start,
                                      runSpacing: 20.0,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        Padding(
                                          key:
                                              UniqueKey(), // Assign a unique key to this child
                                          padding: const EdgeInsets.all(8.0),
                                          child: Header(
                                            username: widget.username ?? "User",
                                          ),
                                        ),
                                        // FutureBuilder<Map<String, int>>(
                                        //   future:
                                        //       tally(), // Call the tally function to get data asynchronously
                                        //   builder: (context, snapshot) {
                                        //     if (snapshot.connectionState ==
                                        //         ConnectionState.waiting) {
                                        //       return Center(
                                        //           child:
                                        //               CircularProgressIndicator(
                                        //                   color:
                                        //                       Theme.of(context)
                                        //                           .colorScheme
                                        //                           .tertiary));
                                        //     } else if (snapshot.hasError) {
                                        //       // Show an error message if data fetching fails
                                        //       return Text(
                                        //           'Error: ${snapshot.error}');
                                        //     } else {
                                        //       // Access the group count from the snapshot data
                                        //       int memberCount =
                                        //           snapshot.data!['members'] ??
                                        //               0;

                                        //       // Display the group count in the InfoCard
                                        // return
                                        OverlayTooltipItem(
                                            displayIndex: 0,
                                            tooltip: (controller) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: OverlayButton(
                                                    title: 'Visa Finder',
                                                    desc:
                                                        'Let us find you the most viable visa for your travel needs',
                                                    controller: controller),
                                              );
                                            },
                                            child: new InfoCard(
                                              icon:
                                                  Icons.travel_explore_rounded,
                                              ////image: 'assets/People.png',

                                              label: 'Visa \nFinder',
                                              // number: '$memberCount',
                                              number: 'Find Your Visa',
                                              onClicked: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: ((context) =>
                                                      MapScreen()),
                                                ));
                                              },
                                              // opFunction: () => tally(),
                                            )),

                                        // FutureBuilder<Map<String, int>>(
                                        //   future:
                                        //       tally(), // Call the tally function to get data asynchronously
                                        //   builder: (context, snapshot) {
                                        //    if (snapshot.connectionState ==
                                        //         ConnectionState.waiting) {
                                        //       // Show a loading indicator while data is being fetched
                                        //       return CircularProgressIndicator();
                                        //     } else if (snapshot.hasError) {
                                        //       // Show an error message if data fetching fails
                                        //       return Text(
                                        //           'Error: ${snapshot.error}');
                                        //     } else {
                                        //       // Access the group count from the snapshot data
                                        //       int groupCount =
                                        //           snapshot.data!['groups'] ?? 0;

                                        //       // Display the group count in the InfoCard
                                        // return
                                        OverlayTooltipItem(
                                            displayIndex: 0,
                                            tooltip: (controller) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: OverlayButton(
                                                    title: 'One Pager',
                                                    desc:
                                                        'View all your assets and services available',
                                                    // desc: 'View all your assets and services available',
                                                    controller: controller),
                                              );
                                            },
                                            child: new InfoCard(
                                              icon:
                                                  Icons.travel_explore_rounded,
                                              //image: 'assets/Group.png',
                                              label: 'Application\nHistory',
                                              // number: '$groupCount',
                                              number: 'Application ',
                                              onClicked: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: ((context) =>
                                                      VisaMap2()),
                                                ));
                                              },
                                              // opFunction: () => tally(),
                                            )),
                                        //     }
                                        //   },
                                        // ),

                                        // InfoCard(
                                        //     icon: Icons.travel_explore_rounded,
                                        //     //image: 'assets/Group.png',

                                        //     label: 'Common \nGroups',
                                        //     //  cardColor: AppColor.blueSubtleHK,
                                        //     number: '\0',
                                        //     opFunction: () => tally(),
                                        //     onClicked: () {
                                        //       Navigator.of(context).push(
                                        //           MaterialPageRoute(
                                        //               builder: ((context) =>
                                        //                   MobileScaffold())));
                                        //     }),
                                        // InfoCard(
                                        //     icon: Icons.travel_explore_rounded,
                                        //     ////image: 'assets/Zone.png',
                                        //     // icon: Icons.travel_explore_rounded,
                                        //     // cardColor: AppColor.redSubtleHK,
                                        //     label: 'Zones \n ',
                                        //     number: '\0',
                                        //     opFunction: () => tally(),
                                        //     onClicked: () {
                                        //       Navigator.of(context).push(
                                        //           MaterialPageRoute(
                                        //               builder: ((context) =>
                                        //                   MobileScaffold())));
                                        //     }),
                                        SizedBox(
                                          height: 210,
                                          child: ListView.builder(
                                            itemCount: 4,
                                            itemBuilder: (context, index) {
                                              // if (index == 0) {
                                              //   return Showcase(
                                              //     key: _scheduleKey,
                                              //     title: 'Apply for a Visa',
                                              //     description: 'TO Schedule Service!',
                                              //     child: MyTile(
                                              //       title: 'Apply for a Visa',
                                              //       action: () {
                                              //         Navigator.of(context).push(
                                              //             MaterialPageRoute(
                                              //                 builder: (context) =>
                                              //                     const VisaApplication()));
                                              //         // final snackBarHelper =
                                              //         //     SnackBarHelper(context);
                                              //         // snackBarHelper
                                              //         //     .showCustomSnackBarWithMenu();
                                              //       },
                                              //     ),
                                              //   );
                                              // } else
                                              if (index == 0) {
                                                return OverlayTooltipItem(
                                                    displayIndex: 0,
                                                    tooltip: (controller) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: OverlayButton(
                                                            title: 'One Pager',
                                                            desc:
                                                                'View all your assets and services available',
                                                            // desc: 'View all your assets and services available',
                                                            controller:
                                                                controller),
                                                      );
                                                    },
                                                    child: MyTile(
                                                      title:
                                                          'Set up User profile',
                                                      action: () {
                                                        // final snackBarHelper =
                                                        //     Snacky(context);
                                                        // snackBarHelper
                                                        //     .showSundaySchoolOptions();
                                                        Navigator.of(context).push(
                                                            new MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const SetupProfile()));
                                                      },
                                                    ));
                                              } else if (index == 1) {
                                                return OverlayTooltipItem(
                                                    displayIndex: 0,
                                                    tooltip: (controller) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: OverlayButton(
                                                            title: 'One Pager',
                                                            desc:
                                                                'View all your assets and services available',
                                                            // desc: 'View all your assets and services available',
                                                            controller:
                                                                controller),
                                                      );
                                                    },
                                                    child: MyTile(
                                                      title: 'Visa Info',
                                                      action: () {
                                                        final snackBarHelper =
                                                            Snacky(context);
                                                        snackBarHelper
                                                            .showVisaInfo();
                                                        // Navigator.of(context).push(new MaterialPageRoute(builder: (context) => SetupProfile));
                                                      },
                                                    ));
                                              } else if (index == 2) {
                                                return OverlayTooltipItem(
                                                    displayIndex: 0,
                                                    tooltip: (controller) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: OverlayButton(
                                                            title: 'One Pager',
                                                            desc:
                                                                'View all your assets and services available',
                                                            // desc: 'View all your assets and services available',
                                                            controller:
                                                                controller),
                                                      );
                                                    },
                                                    child: MyTile(
                                                      title:
                                                          'Cost Analysis Tool',
                                                      action: () {
                                                        // Navigator.of(context).push( MaterialPageRoute(builder: (context) => CostAnalysis));
                                                        // final snackBarHelper =
                                                        //     Mpesa(context);
                                                        // snackBarHelper
                                                        //     .showGivingOptions();
                                                        // Navigator.of(context).push(new MaterialPageRoute(builder: (context) => SetupProfile));
                                                      },
                                                    ));
                                              } else {
                                                return const SizedBox.shrink();
                                              }
                                            },
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap:(){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AllContries()));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                    horizontal: 10.0)
                                                .add(const EdgeInsets.symmetric(
                                                    vertical: 2)),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Travel Recommendations',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilmer',
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const Spacer(flex: 1),
                                                Text(
                                                  'More',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilmer',
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiary,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_rounded,
                                                  size: 14,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 1.0),
                                          // ignore: sized_box_for_whitespace
                                          child: Container(
                                            height: 155,
                                            child: ListView.builder(
                                              itemCount: 5,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return const SizedBox(
                                                  width: 300,
                                                  child: Updates(),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.blockSizeVertical! * 4,
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNav())));
  }
}
