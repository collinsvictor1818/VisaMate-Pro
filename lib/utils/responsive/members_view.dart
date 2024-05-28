  import 'package:flutter/services.dart';
import 'package:visamate/component/cards/updates&events.dart';
  import 'package:visamate/utils/responsive/responsive.dart';
  import 'package:flutter/material.dart';
  import 'package:visamate/component/appbars/appBarActionItems.dart';
  import '../../component/appbars/BottomNav.dart';
  import '../../component/appbars/config/size_config.dart';
  import '../../component/bottom_menu.dart';
  import '../../component/cards/feature_cards.dart';
  import '../../component/drawer.dart';
  import '../../component/cards/my_tile.dart';
  import 'dart:developer';
  import '../../styles/pallete.dart';
  import '../../styles/style.dart';

  // import '../../screens/Scheduling/calendar.dart';
  // void main() => runApp(
  //       ChangeNotifierProvider(
  //         create: (context) => Scg(),
  //         child: MaterialApp(
  //           title: 'Your App Title',
  //           home: MembersView(username: 'YourUsername'),
  //         ),
  //       ),
  // );
  // ignore: must_be_immutable
  class MembersView extends StatefulWidget {
    final String? username; // Add this line
    final String? selectedChurch;
    const MembersView(
        {this.username, // Add this line
        this.selectedChurch});

    @override
    State<MembersView> createState() => _MobileScaffoldState();
  }

  class _MobileScaffoldState extends State<MembersView> {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    final scrollController = ScrollController();
    List<Map<String, dynamic>> filteredStuff = [];
    List<Map<String, dynamic>> _stuff = [];

    // ignore: unused_field
    int _currentIndex = 0;
    bool loading = true;
    Widget? loadingWidget;

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

    final _scrollController = ScrollController();
    final _searchController = SearchController();

    void filterStuff(String query) {
      setState(() {
        filteredStuff = _stuff.where((children) {
          final String userId = children['userId'].toString().toLowerCase();
          final String childrenText =
              children['children'].toString().toLowerCase();
          return userId.contains(query.toLowerCase()) ||
              childrenText.contains(query.toLowerCase());
        }).toList();
      });
    }

    Widget build(BuildContext context) {
      // Wrap your entire Scaffold with ShowcaseView

      return Scaffold(
        body: SizedBox(
          width: 400,
          child: Scaffold(
              key: _drawerKey,
              backgroundColor: Theme.of(context).colorScheme.background,
              drawer: SizedBox(width: 210, child: IconMenu()),
              appBar: !Responsive.isDesktop(context)
                  ? AppBar(
                      elevation: 0,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      leading: IconButton(
                          onPressed: () {
                            _drawerKey.currentState!.openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            size: 27,
                            color: Theme.of(context).colorScheme.tertiary,
                          )),
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
                            padding:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    children: [
                                      Padding(
                                        key:
                                            UniqueKey(), // Assign a unique key to this child
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    PrimaryText(
                                                        text: 'Welcome ',
                                                        size: 28,
                                                        fontWeight: FontWeight.w800,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onBackground),
                                                    PrimaryText(
                                                        text: 'Guest',
                                                        size: 28,
                                                        fontWeight: FontWeight.w800,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .tertiary),
                                                  ],
                                                ),
                                                SearchBar()
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        height: 95,
                                        child: ListView.builder(
                                          itemCount: 5,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            if (index == 0) {
                                              return FeatureCard(
                                                label: 'People',
                                                description: 'All matters people',
                                                cardColor: AppColor.orange,
                                                onClicked: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: ((context) =>
                                                        MembersView()),
                                                  ));
                                                },
                                              );
                                            } else if (index == 1) {
                                              return FeatureCard(
                                                label: 'Giving',
                                                description: 'All giving options',
                                                cardColor: AppColor.orange,
                                                onClicked: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: ((context) =>
                                                        MembersView()),
                                                  ));
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 140,
                                        child: ListView.builder(
                                          itemCount: 2,
                                          itemBuilder: (context, index) {
                                            if (index == 0) {
                                              return  MyTile(
                                                  title: 'Apply for a Visa',
                                                  action: () {
                                                    final snackBarHelper =
                                                        Mpesa(context);
                                                    snackBarHelper
                                                        .showGivingOptions();
                                                  },
                                              );
                                            } else if (index == 1) {
                                              return MyTile(
                                                  title: 'View application Records',
                                                  action: () {
                                                    final snackBarHelper =
                                                        Snacky(context);
                                                    snackBarHelper
                                                        .showVisaInfo();
                                                  },
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                                  horizontal: 10.0)
                                              .add(const EdgeInsets.symmetric(
                                                  vertical: 0)),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Travel Recommendations',
                                                style: TextStyle(
                                                  fontFamily: 'Gilmer',
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
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
                                            horizontal: 5.0),
                                        child: Container(
                                          height: 155,
                                          child: ListView.builder(
                                            itemCount: 5,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return SizedBox(
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
              bottomNavigationBar: BottomNav()),
        ),
      );
    }
  }

  class SearchBar extends StatelessWidget {
    const SearchBar({
      Key? key,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextFormField(
                maxLines: 2,
                minLines: 2,
                cursorColor: Theme.of(context).colorScheme.tertiary,
                style: TextStyle(
                  fontFamily: 'Gilmer',
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).hintColor,
                    fontFamily: "Gilmer",
                    fontWeight: FontWeight.w700,
                  ),
                  focusColor: Theme.of(context).colorScheme.tertiary,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 0,
                    ),
                  ),
                  fillColor: Theme.of(context).colorScheme.secondary,
                  filled: true,
                  prefixIcon:
                      Icon(Icons.search, color: Theme.of(context).hintColor),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 2,
                    ),
                  ),
                ))),
      );
    }
  }
