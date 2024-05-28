import 'package:visamate/styles/style.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive/responsive.dart';

// ignore: must_be_immutable
class InfoCard extends StatelessWidget {
    final IconData? icon; // Icon data instead of image path

  final String label;
  final String number;
  final Color? cardColor;
  VoidCallback? onClicked;
  // final Future<Map<String, int>>? Function() opFunction;

  InfoCard(
      {this.icon,
      required this.label,
      required this.number,
      this.onClicked,
      // this.opFunction,
      this.cardColor});
  static MediaQueryData _mediaQueryData =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  static double? screenWidth = _mediaQueryData?.size.width;
  static double? screenHeight = _mediaQueryData?.size.height;
  static double? blockSizeHorizontal = (screenWidth! / 100);
  static double? blockSizeVertical = screenHeight! / 100;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        constraints: BoxConstraints(
            minWidth:
                Responsive.isDesktop(context) ? 200 : screenWidth! / 2 - 40),
        padding: EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: 15,
            right: Responsive.isMobile(context) ? 20 : 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.secondary,
        ),
        // child: FutureBuilder<Map<String, int>>(
            // future: opFunction(),
            // builder: (context, snapshot) {
              // return Column(
                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.asset(image!, width: 45),
                  Icon(
                  icon!, // Using Icon instead of Image
                  size: 45,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                  SizedBox(
                    height: blockSizeVertical! * 2,
                  ),
                  PrimaryText(
                      text: label,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 18),
                  SizedBox(
                    height: blockSizeVertical! * 2,
                  ),
                       PrimaryText(
                      // text: '$number',
                      text: '',
                      size: 14,
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w700,
                      
                    ),
                      //  SizedBox(
                      // height: blockSizeVertical! * 2,
                    // ),
                ],
              )
            // }
            ),
      // ),
    );
  }
}
