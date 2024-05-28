import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    blockSizeHorizontal = (screenWidth! / 100);
    blockSizeVertical = screenHeight! / 100;
  }
}

// Stateful widget for managing SizeConfig initialization
class SizeAwareWidget extends StatefulWidget {
  // ...

  @override
  _SizeAwareWidgetState createState() => _SizeAwareWidgetState();
}

class _SizeAwareWidgetState extends State<SizeAwareWidget> {
  @override
  void initState() {
    super.initState();
    SizeConfig.init(context); // Initialize SizeConfig with context
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Access SizeConfig values safely
          SizedBox(
            height: SizeConfig.blockSizeVertical ?? 20.0, // Default value
          ),
          // ...other widgets
        ],
      ),
    );
  }
}
