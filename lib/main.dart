import 'package:flutter/material.dart';
import 'package:p2_address_crud/pages/home/components/main_appbar.dart';
import 'package:p2_address_crud/pages/home/home.dart';
import 'package:p2_address_crud/pages/shared/title_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
      title: TitleWidget(text: "Agenda de Direcciones"),
      backgroundColor: const Color.fromARGB(255, 214, 214, 214),
    ),
        body: const Home(),
      )
    );
  }
}

