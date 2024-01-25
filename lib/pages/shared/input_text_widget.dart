import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  InputTextWidget({
    super.key,
    required this.controller,
    this.width = 300,
    this.height = 50,
    this.hintText = ""
  });

  final TextEditingController controller;
  double width, height;
  String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}