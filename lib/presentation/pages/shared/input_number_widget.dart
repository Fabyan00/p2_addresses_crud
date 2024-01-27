import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumberWidget extends StatelessWidget {
  InputNumberWidget({
    super.key,
    required this.controller,
    this.width = 200,
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
        maxLength: 5,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
          )
        ),
      ),
    );
  }
}