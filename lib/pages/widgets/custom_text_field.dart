import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm(
      {super.key,
      this.controller,
      this.hintext,
      this.readonly,
      this.textAlign,
      this.keyboardType,
      this.prefixText,
      this.ontap,
      this.suffixIcon,
      this.onChanged,
      this.fontSize,
      this.autoFocus});
  final TextEditingController? controller;
  final String? hintext;
  final bool? readonly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
  final VoidCallback? ontap;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final double? fontSize;
  final bool? autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus ?? false,
      style: TextStyle(fontSize: fontSize),
      onTap: ontap,
      controller: controller,
      readOnly: readonly ?? false,
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: readonly == null ? keyboardType : null,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintext,
          isDense: true,
          prefixText: prefixText,
          suffix: suffixIcon,
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue, width: 2),
          )),
    );
  }
}
