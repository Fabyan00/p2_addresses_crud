import 'package:flutter/material.dart';
import 'package:p2_address_crud/data/theme.dart';

class InputTextWidget extends StatelessWidget {
  InputTextWidget({
    super.key,
    required this.controller,
    this.width = 300,
    this.height = 42,
    this.hintText = "",
  });

  final TextEditingController controller;
  double width, height;
  String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: inputFormDecoration,
      child: TextField(
        maxLength: 50,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          border: InputBorder.none,
          hintText: hintText,
          counterStyle: inputHintStyle,
          hintStyle: inputHintStyle.copyWith(fontSize: 15)
        ),
      ),
    );
  }
}