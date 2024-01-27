import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/bloc/sqlite_manager/sqlite_manager_bloc.dart';
import 'package:p2_address_crud/presentation/pages/address_form/new_adress_form.dart';
import 'package:p2_address_crud/presentation/pages/shared/body_widget.dart';
import 'package:p2_address_crud/presentation/pages/shared/main_action_button.dart';
import 'package:p2_address_crud/presentation/pages/shared/title_widget.dart';

class CardContent extends StatelessWidget {
  const CardContent({
    super.key,
    required this.addressUsecase,
    required this.addressModel
  });

  final AdressUsecase addressUsecase;
  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BodyWidget(text: addressModel.alias, fontSize: 15, fontColor: Colors.black,)
            ),
            InkWell(
              onTap: () {
                addressUsecase.showAlert(
                  context, 
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TitleWidget(text: "¿Seguro que desea eliminar esta dirección?", fontColor: Colors.black,),
                        const SizedBox(height: 10,),
                        MainActionButton(
                          text: "Eliminar", 
                          action: (){
                          BlocProvider.of<SqliteManagerBloc>(context).add(DeleteElementEvent(addressModel.id, false));
                        }),
                        const SizedBox(height: 10,),
                        MainActionButton(
                          text: "Cancelar", 
                          action: (){
                          Navigator.pop(context);
                        })
                      ],
                    ),
                  ), 
                  200
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                decoration: BoxDecoration(
                  color: AdressUsecase().mainColor,
                  borderRadius: BorderRadius.circular(10)
                  ),
                child: const Icon(Icons.delete, color: Color.fromARGB(255, 139, 38, 38),)
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BodyWidget(text: "Guardada el: " + addressModel.dateUpdated, fontSize: 15, fontColor: Colors.black,),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewAdressForm(addressUsecase: addressUsecase, isEditMode: true, addressModel: addressModel,)),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                decoration: BoxDecoration(
                  color: AdressUsecase().mainColor,
                  borderRadius: BorderRadius.circular(10)
                  ),
                child: const Icon(Icons.edit, color: Color.fromARGB(255, 67, 67, 67),)
              ),
            ),
          ],
        )
      ],
    );
  }
}