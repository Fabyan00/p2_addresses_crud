import 'package:flutter/material.dart';
import 'package:p2_address_crud/pages/shared/main_action_button.dart';
import 'package:p2_address_crud/pages/shared/title_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment:Alignment.bottomCenter,
      children: [
        const SingleChildScrollView(
          child: Column(
            children: [
              TitleWidget(text: "Tus direcciones")
            ],
          ),
        ),
        MainActionButton(text: "Agregar dirección", action: null)
      ],
    );
  }
}