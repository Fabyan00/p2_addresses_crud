import 'package:flutter/material.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/pages/address_form/new_adress_form.dart';
import 'package:p2_address_crud/presentation/pages/shared/body_widget.dart';
import 'package:p2_address_crud/presentation/pages/shared/cutom_divider.dart';
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
                TitleWidget(text: "Detalles:", style: mainTheme.textTheme.titleMedium!,),
                const CustomDivider(),
                const SizedBox(height: 10,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyWidget(text: "Alias: ${addressModel.alias}", style: mainTheme.textTheme.bodyMedium!,),
                      const CustomDivider(color: Color.fromARGB(82, 67, 67, 67), height: 15,),
                      const SizedBox(height: 10,),
                      BodyWidget(text: "País: ${addressModel.country}", style: mainTheme.textTheme.bodyMedium!,),
                      const CustomDivider(color: Color.fromARGB(82, 67, 67, 67), height: 15,),
                      const SizedBox(height: 10,),
                      Visibility(
                        visible: addressModel.state.isNotEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyWidget(text: "Estado: ${addressModel.state}", style: mainTheme.textTheme.bodyMedium!,),
                            const CustomDivider(color: Color.fromARGB(82, 67, 67, 67), height: 15,),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      ),

                      BodyWidget(text: "Ciudad: ${addressModel.city}", style: mainTheme.textTheme.bodyMedium!,),
                      const CustomDivider(color: Color.fromARGB(82, 67, 67, 67), height: 15,),
                      const SizedBox(height: 10,),

                      BodyWidget(text: "Dirección: ${addressModel.address}", style: mainTheme.textTheme.bodyMedium!,),
                      const CustomDivider(color: Color.fromARGB(82, 67, 67, 67), height: 15,),
                      const SizedBox(height: 10,),

                      BodyWidget(text: "Código Postal: ${addressModel.zip}", style: mainTheme.textTheme.bodyMedium!,),
                      const CustomDivider(color: Color.fromARGB(82, 67, 67, 67), height: 15,),
                      const SizedBox(height: 10,),

                      BodyWidget(text: "Guardado: ${addressModel.dateCreated}", style: mainTheme.textTheme.bodyMedium!,),
                      const CustomDivider(color: Color.fromARGB(82, 67, 67, 67), height: 15,),
                      const SizedBox(height: 10,),
                      BodyWidget(text: "Actualizado: ${addressModel.dateUpdated}", style: mainTheme.textTheme.bodyMedium!,),
                      const CustomDivider(color: Color.fromARGB(82, 67, 67, 67), height: 15,),
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                MainActionButton(
                  text: "Modificar",
                  bodyStyle: mainTheme.textTheme.bodyMedium!.copyWith(color: mainTheme.colorScheme.onPrimary),
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