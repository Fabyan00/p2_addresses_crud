import 'package:flutter/material.dart';
import 'package:p2_address_crud/pages/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Agenda de Direcciones'),
        ),
        body: const Home(),
      )
    );
  }
}

