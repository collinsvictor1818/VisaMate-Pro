import 'package:package_info/package_info.dart';
import 'package:visamate/manager/request_manager.dart';
import 'dart:io' show Platform;

import '../page/Visa/visa_info.dart';

class AppManager {
  AppManager._privateConstructor();

  static final AppManager _instance = AppManager._privateConstructor();

  factory AppManager() => _instance;

  String getAppStoreLink() {
    if (Platform.isAndroid) {
      return 'https://play.google.com/store/apps/details?id=com.nickypangers.visamatetravel';
    }
    return "https://google.com";
  }

  Future<bool> isAppLatest() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String latestAppVersion = await RequestManager().getLatestAppVersion();

    List<String> currentVersionInfo = packageInfo.version.split('.');
    List<String> latestVersionInfo = latestAppVersion.split('.');

    for (int i = 0; i < currentVersionInfo.length; i++) {
      int currentVersion = int.parse(currentVersionInfo[i]);
      int latestVersion = int.parse(latestVersionInfo[i]);

      // debugPrint(
      // "currentVersion: $currentVersion latestVersion: $latestVersion");

      if (currentVersion < latestVersion) {
        return false;
      }
    }

    return true;
  }
}
