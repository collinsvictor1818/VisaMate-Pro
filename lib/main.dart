import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:visamate/logic/recommendation_logic.dart';
import 'api/gemini.dart';
import 'common/screens/map_screen.dart';
import 'firebase_options.dart';
import 'page/Visa/AllCountries.dart';
import 'page/Visa/profile.dart';
import 'screens/Onboarding/onboarding.dart';
import 'screens/log_in_page.dart';
import 'utils/responsive/mobile_body.dart';
import 'utils/user_controller.dart';
import 'logic/auth/auth_service.dart';
import 'styles/theme/dark_theme.dart';
import 'styles/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final bool? isFirstLaunch = prefs.getBool('isFirstLaunch');
  final bool? isLoggedIn = prefs.getBool('isLoggedIn');

  runApp(
    ProviderScope(
      child: MyApp(
        isFirstLaunch: isFirstLaunch ?? true,
        isLoggedIn: isLoggedIn ?? false,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isFirstLaunch, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: Theme.of(context).colorScheme.background,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const Currency(),
      // home: UserProfile(recommendationLogic: RecommendationLogic(),),
      // home: isFirstLaunch
      //     ? OnboardingScreen()
      //     : (isLoggedIn ? MobileScaffold() : LogInUser()),
      initialBinding: UserBindings(),
    );
  }
}

class UserBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}
