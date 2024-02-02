import 'package:flutter/material.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/presentation/pages/shared/body_widget.dart';

class MainActionButton extends StatelessWidget {
  MainActionButton({super.key, required this.text, required this.action, required this.bodyStyle});

  final String text;
  final Function()? action;
  final TextStyle bodyStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: mainButtonStyle,
      onPressed: action, 
      child: BodyWidget(text: text, style: bodyStyle,)
    );
  }
}