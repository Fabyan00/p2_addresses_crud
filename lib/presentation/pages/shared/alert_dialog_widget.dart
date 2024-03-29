import 'package:flutter/material.dart';
import 'package:p2_address_crud/data/theme.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key, required this.content, this.height = 200});

  final Widget content;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: mainTheme.colorScheme.background,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: height,
        width: double.maxFinite,
        child: content
      )
    );
  }
}