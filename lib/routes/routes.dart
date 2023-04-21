import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hola/pages/Welcome.dart';
import 'package:hola/pages/home_page.dart';
import 'package:hola/pages/user_info_page.dart';
import 'package:hola/pages/verification.dart';

import '../pages/login.dart';

class Routes {
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String verification = 'verification';
  static const String userInfo = 'userInfo';
  static const String home = 'home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return CupertinoPageRoute(builder: (context) => const WelcomePage());
      case login:
        return CupertinoPageRoute(builder: (context) => const LoginPage());
      case verification:
        final Map args = settings.arguments as Map;
        return CupertinoPageRoute(
            builder: (context) => Verificationpage(
                  smsCodeId: args['smsCodeId'],
                  phoneNumber: args['phoneNumber'],
                ));
      case userInfo:
        return CupertinoPageRoute(builder: (context) => const UserInfoPage());

      case home:
        return CupertinoPageRoute(builder: (context) => const HomePage());

      default:
        return CupertinoPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("No page Route Provided"),
            ),
          ),
        );
    }
  }
}
