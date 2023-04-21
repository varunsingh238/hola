import 'package:flutter/material.dart';

import '../../common/colors.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Read our ",
          style: Theme.of(context).textTheme.titleMedium,
          children: [
            const TextSpan(
              text: 'Privacy Policy. ',
              style: TextStyle(
                color: ColorsApp.blueLight,
                fontFamily: 'Poppins',
              ),
            ),
            TextSpan(
              text: 'Tap  "Agree and continue" to accept the ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const TextSpan(
              text: 'Terms of Services.',
              style: TextStyle(
                color: ColorsApp.blueLight,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
