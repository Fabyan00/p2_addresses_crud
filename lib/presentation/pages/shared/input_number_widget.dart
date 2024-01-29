import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumberWidget extends StatelessWidget {
  InputNumberWidget({
    super.key,
    required this.controller,
    this.width = 200,
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
        // border: Border.all(width: hasError.isEmpty ? 0 : 1, color: hasError.isEmpty ? Colors.transparent : Colors.red)
      ),
      child: TextField(
        maxLength: 5,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
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