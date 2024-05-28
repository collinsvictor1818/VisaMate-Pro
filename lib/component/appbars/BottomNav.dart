      import 'package:flutter/material.dart';
      import 'package:provider/provider.dart';
      import '../../logic/recommendation_logic.dart';
      import '../../page/Visa/profile.dart';
      import '../../screens/Attendance/attendance.dart';
      import '../../styles/pallete.dart';

      class BottomNav extends StatefulWidget {
        final Function(int)? onTap; // Made onTap nullable

        BottomNav({this.onTap});

        static const String home = '/';
        static const String dashboard = '/dashboard';
        static const String registerMember = '/registerMember';
        static const String viewMember = '/viewMember';
        static const String manageUser = '/manageUser';

        @override
        State<BottomNav> createState() => _BottomNavState();
      }

      class _BottomNavState extends State<BottomNav> with TickerProviderStateMixin {
        int _currentIndex = 2;

        @override
        Widget build(BuildContext context) {
          return PhysicalModel(
            clipBehavior: Clip.none,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            child: Padding(
              padding: const EdgeInsets.all(7.5).add(
                  EdgeInsets.symmetric(horizontal: 20)
                      .add(EdgeInsets.only(bottom: 5))),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.secondary),
                height: 75,
                child: Center(
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BM(
                          title: 'Register\nMember',
                          onClick: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: ((context) => Register())));
                          },
                          icon: Icons.airplanemode_on_outlined,
                          index: 0,
                        ),
                        BM(
                          title: 'Attendance\nReport',
                          onClick: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: ((context) => MemberAttendance())));
                          },
                          icon: Icons.airline_stops_rounded,
                          index: 1,
                        ),
                        Logo(
                          title: 'Home',
                          onClick: () {
                            Navigator.of(context).pushNamed(BottomNav.home); // Changed to named route
                          },
                          icon: Icons.home,
                          index: 2,
                        ),
                        BM(
                          title: 'Manage\nViews',
                          onClick: () {
                            Navigator.of(context).pushNamed(BottomNav.manageUser); // Changed to named route
                          },
                          icon: Icons.person, 
                          index: 3,
                        ),
                        BM(
                          title: 'M-Pesa',
                          onClick:  () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: ((context) => MPesa())));
                          },
                          icon: Icons.airlines_rounded,
                          index: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        Widget BM({
          required String title,
          VoidCallback? onClick,
          IconData? icon,
          int? index,
          String? image,
        }) {
          return Expanded(
            child: GestureDetector(
              onTap: onClick,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 25,
                    color: _currentIndex == index
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ),
            ),
          );
        }
      }

      Widget Logo({
        required String title,
        VoidCallback? onClick,
        IconData? icon,
        int? index,
        String? image,
      }) {
        return Expanded(
          child: GestureDetector(
            onTap: onClick,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset("assets/visamate_logo_mark.png"),
                  iconSize: 35,
                  onPressed: onClick,
                ),
              ],
            ),
          ),
        );
      }
