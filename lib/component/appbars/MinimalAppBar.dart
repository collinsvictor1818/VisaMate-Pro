import 'package:flutter/material.dart';

import '../../styles/pallete.dart';

class customAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Common Items',
      theme: new ThemeData(primaryColor: Theme.of(context).colorScheme.background),
    );
  }
}

Widget MinAppBar({
  required String title,
  required VoidCallback onClickedBack,
  required VoidCallback onClickedHome,
}) {
  return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.orange),
          onPressed: onClickedHome),
      actions: [
        IconButton(
            icon: Image.asset("H_Colored.png"),
            iconSize: 35,
            onPressed: onClickedBack),
        Padding(padding: EdgeInsets.all(3)),
      ],
      elevation: 0.0,
      toolbarHeight: 72,
      title: Text(title,
          style: const TextStyle(
              color: AppColor.orange,
              fontFamily: 'Gilmer',
              fontSize: 23,
              fontWeight: FontWeight.w700)),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            
            // color:Theme.of(context).colorScheme.background
            ),
        padding: EdgeInsets.only(bottom: 38),
      ));
}
