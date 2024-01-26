import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/bloc/sqlite_manager/sqlite_manager_bloc.dart';
import 'package:p2_address_crud/presentation/pages/home/home.dart';
import 'package:p2_address_crud/presentation/pages/shared/input_number_widget.dart';
import 'package:p2_address_crud/presentation/pages/shared/input_text_widget.dart';
import 'package:p2_address_crud/presentation/pages/shared/main_action_button.dart';
import 'package:p2_address_crud/presentation/pages/shared/title_widget.dart';
import 'package:sqflite/sqflite.dart';

class NewAdressForm extends StatelessWidget {
  const NewAdressForm(
      {super.key, required this.addressUsecase, required this.isEditMode});

  final AdressUsecase addressUsecase;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: TitleWidget(
            text: isEditMode ? "Modificar Dirección" : "Agregar Dirección",
            fontColor: Colors.black,
          ),
          backgroundColor: const Color.fromARGB(255, 214, 214, 214),
        ),
        body: BlocConsumer<SqliteManagerBloc, SqliteManagerState>(
          listener: (context, state) {
            if(state is SucceedCreatingElementState){
              Navigator.pop(context);
              addressUsecase.showAlert(
                context, 
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TitleWidget(text: state.message, fontColor: Colors.black,),
                      const SizedBox(height: 10,),
                      const CircularProgressIndicator(color: Colors.black,),
                    ],
                  ),
                ), 
                200
              );
              BlocProvider.of<SqliteManagerBloc>(context).add(FetchDataEvent());
            }
          },
          builder: (context, state) {
            return Container(
              color: const Color.fromARGB(255, 214, 214, 214),
              height: double.maxFinite,
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    MainActionButton(
                        text: "Usar mi ubicación",
                        action: () {
                          // addressUsecase.getPlace();
                        }),
                    const SizedBox(
                      height: 50,
                    ),
                    InputTextWidget(
                      controller: addressUsecase.alias,
                      hintText: "Alias",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputTextWidget(
                      controller: addressUsecase.address,
                      hintText: "Dirección",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputTextWidget(
                      controller: addressUsecase.city,
                      hintText: "Ciudad",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 45),
                        alignment: Alignment.centerLeft,
                        child: InputNumberWidget(
                          controller: addressUsecase.zip,
                          hintText: "Código Postal",
                          width: 200,
                        )),
                    const SizedBox(
                      height: 100,
                    ),
                    MainActionButton(
                        text: isEditMode ? "Modificar" : "Guardar",
                        action: () {
                          String status =
                              addressUsecase.validateForm(addressUsecase);
                          if (status.isNotEmpty) {
                            addressUsecase.showAlert(
                                context,
                                Center(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TitleWidget(
                                      text: status,
                                      fontSize: 20,
                                      fontColor: Colors.black54,
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    MainActionButton(
                                      text: "Accept",
                                      action: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                )),
                                200);
                          } else {
                            createAddress(context, addressUsecase);
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MainActionButton(
                        text: "Cancelar", action: () => Navigator.pop(context)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void createAddress(BuildContext context, AdressUsecase addressUsecase) {
  AddressModel model = AddressModel(
      id: 0,
      country: "Mexico",
      address: addressUsecase.address.text,
      city: addressUsecase.city.text,
      state: "Mexico",
      zip: addressUsecase.zip.text,
      dateCreated: "",
      dateUpdated: "");
  BlocProvider.of<SqliteManagerBloc>(context).add(CreateElementEvent(model));
}
