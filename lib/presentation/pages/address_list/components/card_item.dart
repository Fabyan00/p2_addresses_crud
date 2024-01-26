import 'package:flutter/material.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/pages/address_form/new_adress_form.dart';
import 'package:p2_address_crud/presentation/pages/address_list/components/card_content.dart';
import 'package:p2_address_crud/presentation/pages/shared/body_widget.dart';
import 'package:p2_address_crud/presentation/pages/shared/main_action_button.dart';
import 'package:p2_address_crud/presentation/pages/shared/title_widget.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.id, required this.addressUsecase});
  final int id;
  final AdressUsecase addressUsecase;
  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    return Dismissible(
      key:Key(id.toString()),
      onDismissed: (direction){
        //TODO: remove at index from list
      } ,
      child: InkWell(
        onTap: () {
          addressUsecase.showAlert(
            context,
            Stack(
              alignment: Alignment.topRight,
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20,),
                        const TitleWidget(text: "Detalles:", fontSize: 20, fontColor: Colors.black,),
                        const SizedBox(height: 10,),
                        BodyWidget(text: "Esto es un texto largooooooooooooooooooooooooooooooooooossssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss", fontColor: Colors.black,),
                        const SizedBox(height: 40,),
                        MainActionButton(
                          text: "Modificar",
                          action: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NewAdressForm(addressUsecase: addressUsecase, isEditMode: true,)),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close)
                )
              ],
            ),
            350
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 85, 
          width: 150,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 67, 67, 67),
            borderRadius: BorderRadius.circular(10)
          ),
          child: CardContent(date: date, addressUsecase: addressUsecase,),
        ),
      ),
    );
  }
}

