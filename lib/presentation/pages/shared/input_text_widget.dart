import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  InputTextWidget({
    super.key,
    required this.controller,
    this.width = 300,
    this.height = 42,
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
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 226, 224, 224)
      ),
      child: TextField(
        maxLength: 50,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
          )
        ),
      ),
    );
  }
}