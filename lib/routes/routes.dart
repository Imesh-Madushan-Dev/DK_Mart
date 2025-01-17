import 'package:flutter/material.dart';
import '../screens/main/bottom_nav.dart';
import '../screens/onboarding/onboarding.dart';
import '../screens/auth/authentication.dart';

class AppRoutes {
  // Route names as static constants
  static const String splash = '/';
  static const String authentication = '/auth';
   static const String mainPage = '/main';


  // Route generator
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      splash: (context) => const OnBoarding(),
      authentication: (context) => const Authentication(),
      mainPage : (context) => const BottomNavScreen()
    };
  }
}