  // import 'package:flutter/cupertino.dart';
  // import 'package:flutter/material.dart';
  // import 'package:flutter/services.dart';
  // import 'package:provider/provider.dart';
  // import 'package:visamate/common/models/country.dart';
  // import 'package:visamate/common/models/navigation.dart';

  // import '../../component/sidebar/sidebar.dart';
  // // import 'package:visamate/common/utils/constants.dart';

  // class ContentScreen extends StatefulWidget {
  //   const ContentScreen({Key? key}) : super(key: key);

  //   @override
  //   _ContentScreenState createState() => _ContentScreenState();
  // }

  // class _ContentScreenState extends State<ContentScreen> {
  //   @override
  //   void initState() {
  //     super.initState();
  //     SystemChrome.setPreferredOrientations([
  //       DeviceOrientation.portraitUp,
  //     ]);
  //   }

  //   @override
  //   Widget build(BuildContext context) {
  //     var size = MediaQuery.of(context).size;
  //     return Scaffold(
  //       resizeToAvoidBottomInset: true,
  //       body: SizedBox(
  //         height: size.height,
  //         width: size.width,
  //         child: GestureDetector(
  //           behavior: HitTestBehavior.translucent,
  //           onTap: () => FocusScope.of(context).unfocus(),
  //           child: Consumer<Navigation>( // Changed from Country to Navigation
  //             builder: (context, navigation, child) =>
  //                 navigation != null
  //                     ? navigation.getCurrentNavigation(context)
  //                     : Stack(
  //                         children: [
  //                           SizedBox(
  //                             height: size.height,
  //                               width: size.width,
  //                             child: Consumer<NavigationState>(
  //                               builder: (context, navigation, child) =>
  //                                   navigation.getCurrentNavigation(context),
  //                             ),
  //                           ),
  //                           const SideBar(),
  //                         ],
  //                       ),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }
