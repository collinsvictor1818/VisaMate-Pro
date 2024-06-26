// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:visamate/manager/app_manager.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:visamate/common/models/country.dart';
// import 'package:visamate/common/models/country_list.dart';
// import 'package:visamate/common/models/navigation.dart';
// import 'package:visamate/common/models/visa.dart';
// import 'package:visamate/common/screens/content_screen.dart';
// import 'package:visamate/common/screens/onboarding_screen.dart';
// import 'package:visamate/manager/request_manager.dart';
// import 'package:visamate/utils/constants.dart';

// import '../../page/Visa/visa_info.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<bool> _initData(BuildContext context) async {
//     bool isAppLatest = await AppManager().isAppLatest();
//     if (!isAppLatest) {
//       await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("Update Available"),
//           content:
//               Text("Please update the app to experience the latest features"),
//           actions: <Widget>[
//             ElevatedButton(
//               child: Text("Update"),
//               onPressed: () async {
//                 String url = AppManager().getAppStoreLink();
//                 if (!await launch(url)) throw 'Could not launch $url';
//               },
//             ),
//             ElevatedButton(
//               child: Text("Later"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     }

//     VisaData visaData = await RequestManager().getVisaData();
//     Provider.of<VisaData>(context, listen: false).setData(visaData);

//     CountryList countryList = await RequestManager().getCountryList();
//     Provider.of<CountryList>(context, listen: false)
//         .setCountryList(countryList);

//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String? code = preferences.getString("country");

//     debugPrint("init data: get preferences \"country\"");

//     Country country = code != null
//         ? countryList.getCountryByCode(code)
//         : countryList.getCountryList![0];
//     Provider.of<Country>(context, listen: false).setCountry(context, country);

//     bool isReturnUser = await _isReturningUser();

//     return isReturnUser;
//   }

//   Future<bool> _isReturningUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isReturning = prefs.getBool("isReturning") ?? false;
//     return isReturning;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//           future: _initData(context),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               if (snapshot.data == true) {
//                 Timer(const Duration(seconds: 3), () {
//                   Provider.of<NavigationState>(context, listen: false)
//                       .setNavigation(NavigationEvents.homePageClickedEvent);
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ContentScreen()),
//                   );
//                 });
//               } else {
//                 Timer(const Duration(seconds: 3), () {
//                   Provider.of<NavigationState>(context, listen: false)
//                       .setNavigation(NavigationEvents.homePageClickedEvent);

//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const OnBoardingScreen()),
//                   );
//                 });
//               }
//             }
//             return Container(
//               color: kIconBackgroundColor,
//               child: const Center(
//                 child: SpinKitChasingDots(
//                   color: Colors.white,
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
