  import 'package:flutter/material.dart';

import '../../styles/pallete.dart';
import '../../styles/style.dart';
import '../../utils/responsive/responsive.dart';

class Header extends StatelessWidget {
  final String? username;
  final String? group;
  final String? role ; 
  
  const Header({
    this.username,
    this.group,
    this.role
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                  text: 'Welcome ',
                  size: 28,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.onBackground),
           PrimaryText(
                  text: '$username',
                  size: 28,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.tertiary),
          
              // Row(
              //   children: [
              //     PrimaryText(
              //       // text: '$role,$group' ?? 'HFC, HQ' ,
              //       text: 'HFC (HQ) ' ,
              //       size: 16,
              //       fontWeight: FontWeight.w300,
              //       // color:Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              //       color:Theme.of(context).hintColor,
              //     ),
              //       PrimaryText(
              //   // text: '$role,$group' ?? 'HFC, HQ' ,
              //   text: 'Executive' ,
              //   size: 16,
              //   fontWeight: FontWeight.w300,
              //   // color:Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              //   color:Theme.of(context).colorScheme.onBackground,
              // )
              //   ],
              // ),
              
            ]),
      ),
      const Spacer(
        flex: 1,
      ),
      Expanded(
        flex: Responsive.isDesktop(context) ? 1 : 3,
        child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor:Theme.of(context).colorScheme.secondary,
              contentPadding: const EdgeInsets.only(left: 40.0, right: 5),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.background),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.background),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(Icons.search, color: Theme.of(context).colorScheme.onBackground),
              ),
              hintText: 'Search',
              hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontFamily: "Gilmer",
                  fontWeight: FontWeight.w700,
                  fontSize: 14)),
        ),
      ),
    ]);
  }
}
