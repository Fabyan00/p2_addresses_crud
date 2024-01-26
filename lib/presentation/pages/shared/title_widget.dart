import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.fontColor = const Color.fromARGB(255, 200, 200, 200)
  });

  final String text;
  final double fontSize;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text, 
      style: GoogleFonts.raleway(
        textStyle: TextStyle(
          fontSize: fontSize,
          color: fontColor,
        )  
      )
    );
  }
}