import 'package:flutter/material.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/pages/address_form/new_adress_form.dart';
import 'package:p2_address_crud/presentation/pages/shared/body_widget.dart';
import 'package:p2_address_crud/presentation/pages/shared/main_action_button.dart';
import 'package:p2_address_crud/presentation/pages/shared/title_widget.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({
    super.key,
    required this.addressUsecase,
    required this.addressModel,
  });

  final AdressUsecase addressUsecase;
  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyWidget(text: "Alias: " + addressModel.alias, fontColor: Colors.black,),
                      const SizedBox(height: 10,),
                      BodyWidget(text: "País: " + addressModel.country, fontColor: Colors.black,),
                      const SizedBox(height: 10,),
                      BodyWidget(text: "Estado: " + addressModel.state, fontColor: Colors.black,),
                      const SizedBox(height: 10,),
                      BodyWidget(text: "Ciudad: " + addressModel.city, fontColor: Colors.black,),
                      const SizedBox(height: 10,),
                      BodyWidget(text: "Dirección: " + addressModel.address, fontColor: Colors.black,),
                      const SizedBox(height: 10,),
                      BodyWidget(text: "Código Postal: " + addressModel.zip, fontColor: Colors.black,),
                      const SizedBox(height: 10,),
                      BodyWidget(text: "Guardado: " + addressModel.dateCreated, fontColor: Colors.black,),
                      const SizedBox(height: 10,),
                      BodyWidget(text: "Actualizado: " + addressModel.dateUpdated, fontColor: Colors.black,),
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                MainActionButton(
                  text: "Modificar",
                  action: () {  
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewAdressForm(addressUsecase: addressUsecase, isEditMode: true, addressModel: addressModel,)),
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
    );
  }
}