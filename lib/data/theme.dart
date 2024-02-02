import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData mainTheme = ThemeData(
   colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: const Color(0xFF00FEAF),
      onSecondary: const Color(0xFF212121),
      error: const Color(0xFFFD5065),
      onError: Colors.white,
      background: Color.fromARGB(255, 215, 215, 215),
      onBackground: Colors.white,
      surface: Color.fromARGB(134, 161, 161, 161).withOpacity(0.75),
      onSurface: Color.fromARGB(145, 96, 96, 96).withOpacity(0.75),
    ),
    scaffoldBackgroundColor: const Color(0xFF252525),
    textTheme: TextTheme(
      titleMedium: GoogleFonts.raleway(
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.black
        ),
      ),
      bodyMedium: GoogleFonts.raleway(
        textStyle: TextStyle(
          fontSize: 18,
          color: Colors.black
        ),
      ),
    )
);

ButtonStyle mainButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: mainTheme.colorScheme.primary,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);

BoxDecoration inputFormDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: const Color.fromARGB(255, 226, 224, 224),
);

TextStyle inputHintStyle = TextStyle(
  fontSize: 10,
  color: mainTheme.colorScheme.onSurface
);
