// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hola/common/colors.dart';

class ShortHBar extends StatelessWidget {
  const ShortHBar({
    Key? key,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 4,
      width: width ?? 25,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: color ?? ColorsApp.backgroundDark,
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
