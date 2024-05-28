import 'package:flutter/material.dart';
import 'package:visamate/styles/style.dart';
import '../../styles/pallete.dart';
import '../../utils/responsive/size_config.dart';
import 'config/responsive.dart';

class ActionCard extends StatelessWidget {
  final String? image;
  final String? label;
  final String? title;
  final Color? cardColor;
  final VoidCallback? onClicked;

  ActionCard({
    this.image,
    this.label,
    this.title,
    this.onClicked,
    this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        constraints: BoxConstraints(
            minWidth: Responsive.isDesktop(context)
                ? 200
                : SizeConfig.screenWidth! / 2 - 40),
        padding: EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: 15,
            right: Responsive.isMobile(context) ? 20 : 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != null) Image.asset(image!, width: 40),
            if (label != null)
            // const SizedBox(height: 20),
              PrimaryText(
                text: label!,
                size: 18,
                color:Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.w700,
              ),
          ],
        ),
      ),
    );
  }
}
