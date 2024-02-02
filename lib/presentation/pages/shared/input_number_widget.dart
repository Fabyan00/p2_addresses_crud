import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';

class InputNumberWidget extends StatelessWidget {
  InputNumberWidget({
    super.key,
    required this.controller,
    this.width = 200,
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
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      decoration: adressUsecase.isLightMode ? inputFormDecoration : inputFormDecorationDark,
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
          counterStyle:  adressUsecase.isLightMode ? inputHintStyle : inputHintStyleDark,
          hintStyle: adressUsecase.isLightMode ? inputHintStyle.copyWith(fontSize: 14) : inputHintStyleDark.copyWith(fontSize: 14)
        ),
      ),
    );
  }
}