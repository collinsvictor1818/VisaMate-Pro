import 'package:visamate/styles/style.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive/responsive.dart';

// ignore: must_be_immutable
class FeatureCard extends StatelessWidget {
  final String? image;
  final String label;
  final String description;
  final Color? cardColor;
  final Icons? iconData;
  VoidCallback? onClicked;
 

  FeatureCard(
      {this.image,
      required this.label,
      required this.description,
      this.onClicked,
      this.iconData,
    
      this.cardColor});
  static MediaQueryData _mediaQueryData =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  static double? screenWidth = _mediaQueryData.size.width;
  static double? screenHeight = _mediaQueryData.size.height;
  static double? blockSizeHorizontal = (screenWidth! / 100);
  static double? blockSizeVertical = screenHeight! / 100;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
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
            borderRadius: BorderRadius.circular(10),
            // color: cardColor?.withOpacity(0.05),
            color: Theme.of(context).colorScheme.secondary,
            // border: Border.all(width: 0.3, color: Theme.of(context).hintColor.withOpacity(0.05),  )
          ),
          child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image.asset(image!, width: 45),
                     SizedBox(
                      height: blockSizeVertical! *2,
                    ),
                    PrimaryText(
                        text: label,    
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground,
                        size: 24),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    PrimaryText(
                      text: '$description',
                      size: 16,
                      color: cardColor,
                      fontWeight: FontWeight.w700,
                    ),
                       SizedBox(
                      height: blockSizeVertical! * 2,
                    ),
                  ],
             ),
        ),
      ),
    );
  }
}
