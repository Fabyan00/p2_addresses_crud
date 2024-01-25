import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  MainAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: const Color.fromARGB(255, 214, 214, 214),
    );
  }
}