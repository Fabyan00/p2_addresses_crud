import 'package:flutter/material.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/pages/shared/input_text_widget.dart';
import 'package:p2_address_crud/pages/shared/main_action_button.dart';
import 'package:p2_address_crud/pages/shared/title_widget.dart';

class NewAdressForm extends StatelessWidget {
  const NewAdressForm({super.key, required this.addressUsecase});

  final AdressUsecase addressUsecase;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
          title: const TitleWidget(text: "Agregar Dirección", fontColor: Colors.black,),
          backgroundColor: const Color.fromARGB(255, 214, 214, 214),
        ),
        body: Container(
          color: const Color.fromARGB(255, 214, 214, 214),
          height: double.maxFinite,
          width: double.maxFinite,
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MainActionButton(text: "Usar mi ubicación", action: null),
              const SizedBox(height: 10,),
              InputTextWidget(controller: addressUsecase.address, hintText: "Dirección",),
              const SizedBox(height: 10,),
              InputTextWidget(controller: addressUsecase.city, hintText: "Ciudad",),
              const SizedBox(height: 10,),
              InputTextWidget(controller: addressUsecase.zip, hintText: "Código Postal", width: 200,),
              const SizedBox(height: 10,),
              MainActionButton(text: "Guardar", action: null),
              const SizedBox(height: 10,),
              MainActionButton(text: "Cancelar", action: null)
            ],
          ), 
        ),
      ),
    );
  }
}

