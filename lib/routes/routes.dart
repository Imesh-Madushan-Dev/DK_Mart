import 'package:dk_mart_app/main/main_screen.dart';
import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';

import '../screens/onboarding/onboarding.dart';

class AppRoutes {
  // Route names as static constants
  static const String splash = '/';

  static const String mainPage = '/main';
  static const String login = '/login';
  static const String signup = '/signup';

  // Route generator
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      splash: (context) => const OnBoarding(),
      mainPage: (context) => const MainScreen(),
      login: (context) => const LoginScreen(),
      signup: (context) => const RegisterScreen(),
    };
  }
}
