import 'package:visamate/component/appbars/ActionCards.dart';
import 'package:visamate/page/dashboard.dart';
import 'package:visamate/utils/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

























import '../../../styles/pallete.dart';
import 'package:visamate/component/appbars/appBarActionItems.dart';
import '../../component/appbars/config/responsive.dart';
import '../../component/drawer.dart';
import '../../styles/style.dart';
import '../../utils/responsive/desktop_body.dart';
import '../../utils/responsive/mobile_body.dart';
import '../../utils/responsive/size_config.dart';
import '../../utils/responsive/tablet_body.dart';

class People extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        key: _drawerKey,
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: SizedBox(width: 210, child: IconMenu()),
        appBar: !Responsive.isDesktop(context)
            ? AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.background,
                leading: IconButton(
                    onPressed: () {
                      _drawerKey.currentState?.openDrawer();
                    },
                    icon: Icon(Icons.menu, size: 27, color: Theme.of(context).colorScheme.tertiary,)),
                actions: [
                  AppBarActionItems(),
                ],
              )
            : PreferredSize(
                preferredSize: Size.zero,
                child: SizedBox(),
              ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                  text: 'People',
                  size: 30,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.onBackground),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              SizedBox(
                width: SizeConfig.screenWidth,
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    ActionCard(
                        image: 'assets/AddMember.png',
                        // cardColor: Color.fromARGB(28, 25, 51, 51),
                        label: 'Add Member',
                        onClicked:  () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: ((context) => const ResponsiveLayout(mobileBody: MobileScaffold(),tabletBody: TabletScaffold(), desktopBody: DesktopScaffold(),))));
                    },),
                    ActionCard(
                        image: 'assets/ViewMembers.png',
                        //  cardColor: Color.fromARGB(7, 149, 193, 61),
                        label: 'View Members',
                        onClicked: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: ((context) => const ResponsiveLayout(mobileBody: MobileScaffold(),tabletBody: TabletScaffold(), desktopBody: DesktopScaffold(),))));
                    },),
                    ActionCard(
                        image: 'assets/Visitation.png',
                        //  cardColor: AppColor.blueSubtleHK,
                        label: 'Visitation',
                        onClicked: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: ((context) => const ResponsiveLayout(mobileBody: MobileScaffold(),tabletBody: TabletScaffold(), desktopBody: DesktopScaffold(),))));
                    },),
                    ActionCard(
                        image: 'assets/ManageUsers.png',
                        //  cardColor: AppColor.blueSubtleHK,
                        label: 'Manage Users',
                        onClicked: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: ((context) => ManageUsers())));
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 4,
              ),
            ],
          ),
        ));
  }
}
