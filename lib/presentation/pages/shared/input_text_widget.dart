import 'package:flutter/material.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';

class InputTextWidget extends StatelessWidget {
  InputTextWidget({
    super.key,
    required this.controller,
    this.width = 300,
    this.height = 42,
    this.hintText = "",
    required this.adressUsecase
  });

  final TextEditingController controller;
  double width, height;
  String hintText;
  final AdressUsecase adressUsecase;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: adressUsecase.isLightMode ? inputFormDecoration : inputFormDecorationDark,
      child: TextField(
        maxLength: 50,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          border: InputBorder.none,
          hintText: hintText,
          counterStyle:  adressUsecase.isLightMode ? inputHintStyle : inputHintStyleDark,
          hintStyle: adressUsecase.isLightMode ? inputHintStyle.copyWith(fontSize: 14) : inputHintStyleDark.copyWith(fontSize: 14)
        ),
      ),
    );
  }
}