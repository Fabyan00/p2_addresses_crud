import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/bloc/place/place_bloc.dart';
import 'package:p2_address_crud/presentation/bloc/sqlite_manager/sqlite_manager_bloc.dart';
import 'package:p2_address_crud/presentation/pages/address_form/components/country_state_city_input.dart';
import 'package:p2_address_crud/presentation/pages/shared/input_number_widget.dart';
import 'package:p2_address_crud/presentation/pages/shared/input_text_widget.dart';
import 'package:p2_address_crud/presentation/pages/shared/main_action_button.dart';
import 'package:p2_address_crud/presentation/pages/shared/title_widget.dart';

class NewAdressForm extends StatelessWidget {
  const NewAdressForm(
      {super.key,
      required this.addressUsecase,
      required this.isEditMode,
      required this.addressModel});

  final AdressUsecase addressUsecase;
  final bool isEditMode;
  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    int id = 0;
    if (isEditMode) {
      id = addressModel.id;
      addressUsecase.alias.text = addressModel.alias;
      addressUsecase.country = addressModel.country;
      addressUsecase.state = addressModel.state;
      addressUsecase.city = addressModel.city;
      addressUsecase.address.text = addressModel.address;
      addressUsecase.zip.text = addressModel.zip;
    }
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: TitleWidget(
            text: isEditMode ? "Modificar Dirección" : "Agregar Dirección",
            fontColor: Colors.black,
          ),
          backgroundColor: const Color.fromARGB(255, 214, 214, 214),
        ),
        body: BlocConsumer<PlaceBloc, PlaceState>(
          listener: (context, state) async {
            manageUserLocationResponse(context, state, addressUsecase);
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
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        MainActionButton(
                            text: "Usar mi ubicación",
                            action: () async {
                                addressUsecase.getLocationInfo(context);
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: InputTextWidget(
                        controller: addressUsecase.alias,
                        hintText: "Alias",
                        height: 50,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CountryStateCityInput(addressUsecase: addressUsecase),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: InputTextWidget(
                            controller: addressUsecase.address,
                            hintText: "Dirección",
                            width: 200,
                            height: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: InputNumberWidget(
                              controller: addressUsecase.zip,
                              hintText: "Código Postal",
                              width: 150,
                              height: 50,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 200,
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
                            createAddress(
                                context, addressUsecase, id, isEditMode);
                          }
                        }),
                    Visibility(
                      visible: isEditMode,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          MainActionButton(
                            text: "Eliminar",
                            action: () {
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
                            }
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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

void createAddress(BuildContext context, AdressUsecase addressUsecase, int id, bool isEditMode) {
  AddressModel model = AddressModel(
    id: id,
    alias: addressUsecase.alias.text,
    country: addressUsecase.country,
    address: addressUsecase.address.text,
    city: addressUsecase.city,
    state: addressUsecase.state,
    zip: addressUsecase.zip.text,
    dateCreated: "",
    dateUpdated: ""
  );

  if (isEditMode) {
    BlocProvider.of<SqliteManagerBloc>(context).add(UpdateElementEvent(model));
  } else {
    BlocProvider.of<SqliteManagerBloc>(context).add(CreateElementEvent(model));
  }
}

void manageUserLocationResponse(BuildContext context, PlaceState state, AdressUsecase adressUsecase){
  if(state is LoadingState){
    adressUsecase.showAlert(
      context,
      const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(text: "Obteniendo ubicación. . .", fontColor: Colors.black54,),
            SizedBox(height: 10,),
            CircularProgressIndicator(color: Colors.black54,),
          ],
        ),
      ),
      200
    );
  }
  
  if(state is SucceedSettingPlace){
    Navigator.pop(context);
    adressUsecase.country = state.country;
    adressUsecase.state = state.state;
    adressUsecase.city = state.city;
    adressUsecase.address.text = state.address;
    adressUsecase.zip.text = state.zip;
  }

  if(state is FailedSettingPlace){
    // Navigator.pop(context);
     adressUsecase.showAlert(
      context,
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(text: state.message, fontSize: 20, fontColor: Colors.black54,),
            const SizedBox(height: 10,),
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
  
  if(state is FailedSettingUserLocation){
    adressUsecase.showAlert(
      context,
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(text: state.message, fontSize: 20, fontColor: Colors.black54,),
            const SizedBox(height: 10,),
            MainActionButton(
              text: "Acceptar",
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