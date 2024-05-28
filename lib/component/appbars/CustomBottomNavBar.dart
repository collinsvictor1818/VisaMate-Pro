// import 'package:flutter/material.dart';

// import '../../styles/pallete.dart';

// class CustomAnimatedBottomBar extends StatelessWidget {

//   CustomAnimatedBottomBar({
//      key,
//     this.selectedIndex = 0,
//     this.showElevation = true,
//     this.iconSize = 24,
//     this.itemCornerRadius = 50,
//     this.containerHeight = 56,
//     this.animationDuration = const Duration(milliseconds: 270),
//     this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
//     required this.items,
//     this.onItemSelected,
//     this.curve = Curves.linear,
//   }) :  super(key: key);

//   final int selectedIndex;
//   final double iconSize;
//   final bool showElevation;
//   final Duration animationDuration;
//   final List<BottomNavyBarItem> items;
//   final ValueChanged<int>? onItemSelected;
//   final MainAxisAlignment mainAxisAlignment;
//   final double itemCornerRadius;
//   final double containerHeight;
//   final Curve curve;

//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         boxShadow: [
//           if (showElevation)
//             const BoxShadow(
//               color: Colors.black12,
//               blurRadius: 2,
//             ),
//         ],
//       ),
//       child: SafeArea(
//         child: Container(
//           color: Colors.transparent,
//           width: double.infinity,
//           height: containerHeight,
//           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
//           child: Row(
//             mainAxisAlignment: mainAxisAlignment,
//             children: items.map((item) {
//               var index = items.indexOf(item);
//               return GestureDetector(
//                 onTap: () => onItemSelected!(index),
//                 child: _ItemWidget(
//                   item: item,
//                   iconSize: iconSize,
//                   isSelected: index == selectedIndex,
//                   backgroundColor: Theme.of(context).colorScheme.tertiary,
//                   itemCornerRadius: itemCornerRadius,
//                   animationDuration: animationDuration,
//                   curve: curve,
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ItemWidget extends StatelessWidget {
//   final double iconSize;
//   final bool isSelected;
//   final BottomNavyBarItem item;
//   final Color backgroundColor;
//   final double itemCornerRadius;
//   final Duration animationDuration;
//   final Curve curve;

//   const _ItemWidget({
//      key,
//     required  this.item,
//    required   this.isSelected,
//    required   this.backgroundColor,
//    required   this.animationDuration,
//  required     this.itemCornerRadius,
//      required this.iconSize,
//     this.curve = Curves.linear,
//   })  : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Semantics(
//       container: true,
//       selected: isSelected,
//       child: AnimatedContainer(
//         width: isSelected ? 130 : 50,
//         height: double.maxFinite,
//         duration: animationDuration,
//         curve: curve,
//         decoration: BoxDecoration(
//           color:
//           isSelected ? item.activeColor!.withOpacity(0.2) : backgroundColor,
//           borderRadius: BorderRadius.circular(itemCornerRadius),
//         ),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           physics: NeverScrollableScrollPhysics(),
//           child: Container(
//             width: isSelected ? 130 : 50,
//             padding: EdgeInsets.symmetric(horizontal: 8),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 IconTheme(
//                   data: IconThemeData(
//                     size: iconSize,
//                     color: isSelected
//                         ? item.activeColor
//                         : item.inactiveColor == null
//                         ? item.activeColor
//                         : item.inactiveColor,
//                   ),
//                   child: item.icon,
//                 ),
//                 if (isSelected)
//                   Expanded(
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 4),
//                       child: DefaultTextStyle.merge(
//                         style: TextStyle(
//                           color: item.activeColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         maxLines: 1,
//                         // textAlign: item.textAlign,
//                         child: item.title,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class BottomNavyBarItem {

//   final Widget icon;
//   final Widget title;
//   final Color? activeColor;
//   final Color? inactiveColor;
//   BottomNavyBarItem(this.title, {
//     required  this.icon,
//   // required    this.title,
//     this.inactiveColor = AppColor.orange,
//     this.activeColor = AppColor.orange, required String title});
  
//   // final Colors 
//   // final Colors inactiveColor = AppColor.orange as Colors;
//   @override
// Widget build(BuildContext context){return Column(children: [icon, title],);}
// }