import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../styles/pallete.dart';
import '../log_in_page.dart';
// import '../screens/log_in_page.dart';

class OnboardingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: OverBoard(
        allowScroll: true,
        pages: pages,
        skipText: 'Skip',
        nextText: 'Next',
        finishText: 'Finish',
        showBullets: true,
        inactiveBulletColor: Theme.of(context).colorScheme.tertiary,
        buttonColor: AppColor.white,
        skipCallback: () async {
          await _completeOnboarding(context, ref);
        },
        finishCallback: () async {
          await _completeOnboarding(context, ref);
        },
      ),
    );
  }

  Future<void> _completeOnboarding(BuildContext context, WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LogInUser()));
  }

  final pages = [
    PageModel(
      color: const Color(0xFF211D49),
      imageAssetPath: 'assets/images/destination.png',
      title: 'Seamless travels',
      titleColor: const Color(0xFFEB5D2D),
      body: 'VisaMatePro removes the travel visa hurdle, paving the way for unforgettable adventures. Our app simplifies your visa journey.',
      doAnimateImage: true,
    ),
    PageModel(
      color: const Color(0xFFEB5D2D),
      imageAssetPath: 'assets/images/pass.png',
      title: 'Skip the confusion',
      body: 'VisaMatePro streamlines your visa experience. Find visas, track applications, and get real-time updates. Travel worry-free - let VisaMatePro be your guide.',
      doAnimateImage: true,
    ),
    PageModel(
      color: const Color(0xFF211D49),
      titleColor: const Color(0xFFEB5D2D),
      imageAssetPath: 'assets/images/world.png',
      title: 'Travel smarter',
      body: 'VisaMatePro puts the world at your fingertips. Our app simplifies visa searches, tracks applications, and offers expert advice. Explore with confidence.',
      doAnimateImage: true,
    ),
  ];
}
