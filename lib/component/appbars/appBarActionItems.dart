import 'package:flutter/material.dart';
import 'package:visamate/screens/Account/notifications.dart';
import 'package:visamate/styles/pallete.dart';
import '../../page/Settings.dart';
import '../../page/Dashboard.dart';
import '../../page/Visa/profile.dart';
import '../../screens/Settings/settings_screen.dart';
import '../../utils/responsive/desktop_body.dart';
import '../../utils/responsive/mobile_body.dart';
import '../../utils/responsive/responsive_layout.dart';
import '../../utils/responsive/tablet_body.dart';
import '../bottom_menu.dart';

class AppBarActionItems extends StatelessWidget {
  const AppBarActionItems();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
          IconButton(
            icon: Icon(Icons.notifications,
                size: 27, color: Theme.of(context).colorScheme.tertiary),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Notifications(),
              ));
                //  final snackBarHelper = SnackBarHelper(context);
                //                   snackBarHelper.showPrompt();
                               
            }),
        IconButton(
            icon: Icon(Icons.settings, size: 27, color: Theme.of(context).colorScheme.tertiary),
            onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => SettingScreen())));
                    },),
        SizedBox(width: 8),

        // To implement signout function

        SizedBox(width: 10),
      ],
    );
  }
}
