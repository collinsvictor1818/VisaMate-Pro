import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visamate/screens/visa_requirements.dart';
import 'package:visamate/page/Visa/country_information.dart';
import '../utils/responsive/mobile_body.dart';
import 'navrouter.dart';
import 'text.dart';

class IconMenu extends StatefulWidget {
  const IconMenu();

  @override
  State<IconMenu> createState() => _IconMenuState();
}

class _IconMenuState extends State<IconMenu> {
  final padding = const EdgeInsets.symmetric(horizontal: 30);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    buildMenuItem(
                      context: context,
                      text: 'Visa Requirements',
                      icon: CupertinoIcons.question_circle_fill,
                      onClicked: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VisaInfoPage(),
                          ),
                        );
                      },
                    ),
                    buildMenuItem(
                      context: context,
                      text: 'Country Information',
                      icon: CupertinoIcons.globe,
                      onClicked: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CountryInfo(),
                          ),
                        );
                      },
                    ),
                    buildMenuItem(
                      context: context,
                      text: 'Cost Analysis tool',
                      icon: Icons.monetization_on_rounded,
                      onClicked: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MobileScaffold(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildMenuItem({
  required String text,
  required BuildContext context,
  required IconData icon,
  required VoidCallback onClicked,
}) {
  const hoverColor = Colors.red;
  return ListTile(
    leading: Icon(icon, color: Theme.of(context).colorScheme.tertiary),
    dense: true,
    title: Transform.translate(
      offset: const Offset(-15, 0),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Jina(
          text: text,
          rangi: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    ),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}
