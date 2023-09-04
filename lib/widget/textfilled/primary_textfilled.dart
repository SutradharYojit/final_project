import 'package:flutter/material.dart';

class PrimaryTextFilled extends StatelessWidget {
  const PrimaryTextFilled({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final Widget ?prefixIcon;
  final TextInputType ?keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          // border: buildOutlineInputBorder(),
        errorBorder: buildOutlineInputBorder(),
        focusedErrorBorder: buildOutlineInputBorder()
      ),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
        color: Colors.purple.shade500
    ),
    borderRadius: BorderRadius.circular(15),
  );
}
