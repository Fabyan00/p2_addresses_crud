import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/main.dart';
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
    return Container(
      alignment: Alignment.bottomLeft,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              InkWell(
                onTap: () {
                  addressUsecase.showAlert(
                    context, 
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TitleWidget(text: "¿Seguro que desea eliminar esta dirección?", style: mainTheme.textTheme.titleMedium!,),
                          const SizedBox(height: 10,),
                          MainActionButton(
                            text: "Eliminar", 
                            bodyStyle: mainTheme.textTheme.bodyMedium!.copyWith(color: mainTheme.colorScheme.onPrimary),
                            action: (){
                            BlocProvider.of<SqliteManagerBloc>(context).add(DeleteElementEvent(addressModel.id, false));
                          }),
                          const SizedBox(height: 10,),
                          MainActionButton(
                            text: "Cancelar", 
                            bodyStyle: mainTheme.textTheme.bodyMedium!.copyWith(color: mainTheme.colorScheme.onPrimary),
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
                  child: const Icon(Icons.delete, color: Color.fromARGB(255, 139, 38, 38),)
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: BodyWidget(text: addressModel.address, style: mainTheme.textTheme.bodyMedium!.copyWith(fontSize: 15, color: usecase.mainColor.colorScheme.primary))
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: BodyWidget(text: addressModel.dateUpdated, style: mainTheme.textTheme.bodyMedium!.copyWith(fontSize: 12, color: usecase.mainColor.colorScheme.onSurface),),
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
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Icon(Icons.edit, color: addressUsecase.mainColor.colorScheme.primary)
                ),
              ),
            ],
          ),
         
        ],
      ),
    );
  }
}