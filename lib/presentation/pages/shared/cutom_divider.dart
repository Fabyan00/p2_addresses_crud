import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.color = Colors.black, this.height = 20});

  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: 1,
      color: color
    );
  }
}