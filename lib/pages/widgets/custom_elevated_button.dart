import 'package:flutter/material.dart';

import '../../common/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.buttonWidth,
    required this.onPressed,
    required this.text,
  });
  final double? buttonWidth;
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: buttonWidth ?? MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: ColorsApp.blueDark,
              shadowColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              elevation: 0),
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium,
          )),
    );
  }
}
