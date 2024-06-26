import 'package:flutter/material.dart';
import 'package:visamate/common/screens/about_screeen.dart';
import 'package:visamate/common/screens/filtered_list_screen.dart';
import 'package:visamate/common/screens/home_screen.dart';
import 'package:visamate/common/screens/list_screen.dart';
import 'package:visamate/common/screens/search_screen.dart';

import '../../utils/constants.dart';
import '../../utils/responsive/mobile_body.dart';
import 'country.dart';

enum NavigationEvents {
  homePageClickedEvent,
  searchClickedEvent,
  mapClickedEvent,
  listClickedEvent,
  visaFreeListClickedEvent,
  visaOnArrivaListClickedEvent,
  visaRequiredListClickedEvent,
  covidBanListClickedEvent,
  noAdmissionListClickedEvent,
  aboutClickedEvent,
}

class NavigationState extends ChangeNotifier {
  late NavigationEvents currentNavigationEvent;
  static Country? _passportCountry;
  static Country? _destinationCountry;

  setSearchNavigation({Country? passportCountry, Country? destinationCountry}) {
    _passportCountry = passportCountry;
    _destinationCountry = destinationCountry;
    setNavigation(NavigationEvents.searchClickedEvent);
  }

  setNavigation(NavigationEvents state) {
    currentNavigationEvent = state;
    notifyListeners();
  }

  Widget getCurrentNavigation(BuildContext context) {
    switch (currentNavigationEvent) {
      // case NavigationEvents.homePageClickedEvent:
      //   return const HomeScreen();
      case NavigationEvents.homePageClickedEvent:
        return const MobileScaffold();
      case NavigationEvents.listClickedEvent:
        return ListScreen();
      case NavigationEvents.visaFreeListClickedEvent:
        return FilteredListScreen(category: kVisaFree);
      case NavigationEvents.visaOnArrivaListClickedEvent:
        return FilteredListScreen(category: kVisaOnArrival);
      case NavigationEvents.visaRequiredListClickedEvent:
        return FilteredListScreen(category: kVisaRequired);
      case NavigationEvents.covidBanListClickedEvent:
        return FilteredListScreen(category: kCovidBan);
      case NavigationEvents.noAdmissionListClickedEvent:
        return FilteredListScreen(category: kNoAdmission);
      // case NavigationEvents.searchClickedEvent:
      //   return SearchScreen(
      //       passportCountry: _passportCountry,
      //       destinationCountry: _destinationCountry);
      case NavigationEvents.aboutClickedEvent:
        return AboutScreen();
      default:
        // return const HomeScreen();
        return const MobileScaffold();
    }
  }
}
