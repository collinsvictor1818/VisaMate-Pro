import 'package:flutter/material.dart';
import '../../styles/pallete.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(72); // Adjust the height as needed

  final String title;
  final VoidCallback? onClickedBack;
  final VoidCallback? onClickedHome;

  const CustomAppBar({
    required this.title,
     this.onClickedBack,
     this.onClickedHome,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).colorScheme.tertiary),
        onPressed: onClickedHome,
      ),
      actions: [
        IconButton(
          icon: Image.asset("assets/visamate_logo_mark.png"),
          iconSize: 35,
          onPressed: onClickedBack,
        ),
        Padding(padding: EdgeInsets.all(3)),
      ],
      elevation: 0.0,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontFamily: 'Gilmer',
          fontSize: 23,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.background, Theme.of(context).colorScheme.background],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        padding: EdgeInsets.only(bottom: 38),
      ),
    );
  }
}
