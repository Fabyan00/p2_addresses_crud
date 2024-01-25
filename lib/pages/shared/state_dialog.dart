import 'package:flutter/material.dart';

class StateDialog extends StatelessWidget {
  const StateDialog({super.key, required this.content});

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.red,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 200,
        width: double.maxFinite,
        child: content
      )
    );
  }
}