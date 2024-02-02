import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 226, 224, 224),
      ),
      child: TextField(
        maxLength: 50,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          border: InputBorder.none,
          hintText: hintText,
          counterStyle: const TextStyle(
            fontSize: 10,
            color: Color.fromARGB(123, 0, 0, 0)
          ),
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.black54
          )
        ),
      ),
    );
  }
}