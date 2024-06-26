// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:visamate/common/models/country.dart';
// import 'package:visamate/common/models/navigation.dart';
// import 'package:visamate/common/models/visa.dart';

// import '../../component/cards/recommended_card.dart';
// import '../../utils/constants.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   String _getCurrentTime() {
//     var now = DateTime.now();

//     return DateFormat('kk').format(now);
//   }

//   String _getGreetings(String hourString) {
//     int hour = int.parse(hourString);

//     if (hour >= 5 && hour < 12) {
//       return "Good Morning";
//     }
//     if (hour >= 12 && hour < 17) {
//       return "Good Afternoon";
//     }
//     return "Good Evening";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.only(left: kSidebarMargin + 10, right: 10),
//         child: Consumer<Country>(
//           builder: (context, currentCountry, child) =>
//               _buildMain(context, currentCountry),
//         ),
//       ),
//     );
//   }

//   Widget _buildMain(BuildContext context, Country currentCountry) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildHeader(context, currentCountry),
//           _buildRecommendedList(context,
//               height: 170.0,
//               list: Provider.of<CountryCategoryList>(context)
//                       .getcountryCategoryListVf
//                       .data ??
//                   []),
//           // _buildSeeAllCountriesButton(context),
//           _buildCategoryLengthList(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context, Country currentCountry) {
//     return IntrinsicHeight(
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Expanded(
//             child: _buildGreetings(context),
//           ),
//           SizedBox(
//             width: 40,
//             height: 40,
//             child: SvgPicture.asset(
//                 "assets/flags/${currentCountry.code!.toLowerCase()}.svg"),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRecommendedList(BuildContext context,
//       {double height = 170, required List<dynamic> list}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildCategoryHeader(context,
//             title: "Top 5 Visa-Free", showViewMore: true, onClick: () {
//           Provider.of<NavigationState>(context, listen: false)
//               .setNavigation(NavigationEvents.visaFreeListClickedEvent);
//         }),
//         SizedBox(
//           height: height,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: list.length > 5 ? 5 : list.length,
//             itemBuilder: (context, index) => RecommendedCard(
//               code: list[index],
//               visa: "Visa Free",
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCategoryHeader(BuildContext context,
//       {required String title,
//       required bool showViewMore,
//       Function()? onClick}) {
//     return Padding(
//       padding: const EdgeInsets.all(0),
//       // padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 26,
//             ),
//           ),
//           showViewMore
//               ? GestureDetector(
//                   onTap: onClick ??
//                       () {
//                         debugPrint("clicked view visa-free");
//                       },
//                   child: const Text(
//                     'View Visa-Free',
//                     style: kViewMoreTextStyle,
//                   ),
//                 )
//               : const SizedBox.shrink(),
//         ],
//       ),
//     );
//   }

//   Widget _buildGreetings(BuildContext context) {
//     var currentTime = _getCurrentTime();
//     return Container(
//       alignment: Alignment.centerLeft,
//       padding: const EdgeInsets.only(left: kTabWidth),
//       height: 110,
//       child: Text(
//         "${_getGreetings(currentTime)}",
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 30,
//         ),
//         textAlign: TextAlign.start,
//       ),
//     );
//   }

//   Widget _buildCategoryLengthList(BuildContext context) {
//     CountryCategoryList countryCategoryList =
//         Provider.of<CountryCategoryList>(context, listen: false)
//             .getCountryCategoryList;
//     return Column(
//       children: [
//         _buildCategoryLengthCard(
//           context,
//           category: countryCategoryList.getcountryCategoryListVf,
//           color: kVisaFreeColor,
//           // title: kVisaFreeString,
//           title: AppLocalizations.of(context)?.visaFree ?? kVisaFreeString,
//           iconData: kVisaFreeIconData,
//           navigationEvents: NavigationEvents.visaFreeListClickedEvent,
//         ),
//         _buildCategoryLengthCard(
//           context,
//           category: countryCategoryList.getcountryCategoryListVoa,
//           color: kVisaOnArrivalColor,
//           // title: kVisaOnArrivalString,
//           title: AppLocalizations.of(context)?.visaOnArrival ??
//               kVisaOnArrivalString,
//           iconData: kVisaOnArrivalIconData,
//           navigationEvents: NavigationEvents.visaOnArrivaListClickedEvent,
//         ),
//         _buildCategoryLengthCard(
//           context,
//           category: countryCategoryList.getcountryCategoryListVr,
//           color: kVisaRequiredColor,
//           title:
//               AppLocalizations.of(context)?.visaRequired ?? kVisaRequiredString,
//           // title: kVisaRequiredString,
//           iconData: kVisaRequiredIconData,
//           navigationEvents: NavigationEvents.visaRequiredListClickedEvent,
//         ),
//         _buildCategoryLengthCard(
//           context,
//           category: countryCategoryList.getcountryCategoryListCb,
//           color: kCovidBanColor,
//           title: AppLocalizations.of(context)?.covidBan ?? kCovidBanString,
//           // title: kCovidBanString,
//           iconData: kCovidBanIconData,
//           navigationEvents: NavigationEvents.covidBanListClickedEvent,
//         ),
//         _buildCategoryLengthCard(
//           context,
//           category: countryCategoryList.getcountryCategoryListNa,
//           color: kNoAdmissionColor,
//           title:
//               AppLocalizations.of(context)?.noAdmission ?? kNoAdmissionString,
//           // title: kNoAdmissionString,
//           iconData: kNoAdmissionIconData,
//           navigationEvents: NavigationEvents.noAdmissionListClickedEvent,
//         ),
//       ],
//     );
//   }

//   Widget _buildCategoryLengthCard(
//     BuildContext context, {
//     required CountryCategory category,
//     required Color color,
//     required String title,
//     required NavigationEvents navigationEvents,
//     IconData iconData = FontAwesomeIcons.check,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         Provider.of<NavigationState>(context, listen: false)
//             .setNavigation(navigationEvents);
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 5),
//         child: ListTile(
//           leading: FaIcon(iconData),
//           title: Text(title),
//           trailing: Text("${category.length}"),
//           tileColor: color,
//         ),
//       ),
//     );
//   }
// }
