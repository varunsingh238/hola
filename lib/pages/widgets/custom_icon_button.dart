import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.onTap,
      required this.icon,
      this.iconSize,
      this.minWidth,
      this.iconColor,
      this.background,
      this.border});
  final VoidCallback onTap;
  final IconData icon;
  final double? iconSize;
  final double? minWidth;
  final Color? iconColor;
  final Color? background;
  final BoxBorder? border;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: background, shape: BoxShape.circle, border: border),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: iconColor ?? Colors.grey,
        ),
        iconSize: iconSize ?? 22,
        splashColor: Colors.transparent,
        splashRadius: (minWidth ?? 45) - 25,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
          minWidth: minWidth ?? 45,
          minHeight: minWidth ?? 45,
        ),
      ),
    );
  }
}
