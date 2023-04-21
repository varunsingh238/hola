import 'package:flutter/material.dart';
import 'package:hola/pages/widgets/custom_elevated_button.dart';
import 'package:hola/pages/widgets/lang_selector.dart';
import 'package:hola/pages/widgets/privacy_and_terms.dart';
import 'package:hola/routes/routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  navigateToLoginPage(context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Image.asset(
                    "assets/images/main_logo.png",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Welcome to Holaa!",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const PrivacyAndTerms(),
                  CustomElevatedButton(
                    text: "AGREE AND CONTINUE",
                    onPressed: () => navigateToLoginPage(context),
                    //   Navigator.push(
                    // context,
                    // CupertinoPageRoute(
                    //   builder: (builder) => const LoginPage(),
                    // ),
                    //  ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const LanguageSelector()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
