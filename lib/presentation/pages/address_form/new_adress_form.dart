import 'package:flutter/material.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/pages/shared/input_number_widget.dart';
import 'package:p2_address_crud/presentation/pages/shared/input_text_widget.dart';
import 'package:p2_address_crud/presentation/pages/shared/main_action_button.dart';
import 'package:p2_address_crud/presentation/pages/shared/title_widget.dart';

class NewAdressForm extends StatelessWidget {
  const NewAdressForm({
    super.key, 
    required this.addressUsecase,
    required this.isEditMode
  });

  final AdressUsecase addressUsecase;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
          title: TitleWidget(text: isEditMode ? "Modificar Dirección" : "Agregar Dirección", fontColor: Colors.black,),
          backgroundColor: const Color.fromARGB(255, 214, 214, 214),
        ),
        body: Container(
          color: const Color.fromARGB(255, 214, 214, 214),
          height: double.maxFinite,
          width: double.maxFinite,
          child:  SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20,),
                MainActionButton(
                  text: "Usar mi ubicación", 
                  action: (){
                    // addressUsecase.getPlace();
                  }
                ),
                const SizedBox(height: 50,),
                InputTextWidget(controller: addressUsecase.alias, hintText: "Alias",),
                const SizedBox(height: 20,),
                InputTextWidget(controller: addressUsecase.address, hintText: "Dirección",),
                const SizedBox(height: 20,),
                InputTextWidget(controller: addressUsecase.city, hintText: "Ciudad",),
                const SizedBox(height: 20,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 45),
                  alignment: Alignment.centerLeft,
                  child: InputNumberWidget(controller: addressUsecase.zip, hintText: "Código Postal", width: 200,)
                ),
                const SizedBox(height: 100,),
                MainActionButton(
                  text: isEditMode ? "Modificar" : "Guardar", 
                  action: (){
                    String status = addressUsecase.validateForm(addressUsecase);
                    if(status.isNotEmpty){
                      addressUsecase.showAlert(
                        context, 
                         Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TitleWidget(text: status, fontSize: 20, fontColor: Colors.black54,),
                              const SizedBox(height: 40,),
                              MainActionButton(
                                text: "Accept",
                                action: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          )
                        ),
                        200
                      );
                    }
                  }
                ),
                const SizedBox(height: 10,),
                MainActionButton(text: "Cancelar", action:() => Navigator.pop(context)),
                const SizedBox(height: 20,),
              ],
            ),
          ), 
        ),
      ),
    );
  }
}

