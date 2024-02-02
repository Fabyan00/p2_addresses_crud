import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/domain/form_functions.dart';
import 'package:p2_address_crud/presentation/bloc/place/place_bloc.dart';
import 'package:p2_address_crud/presentation/bloc/sqlite_manager/sqlite_manager_bloc.dart';
import 'package:p2_address_crud/presentation/cubit/cities_drop_down/cities_dropdown_cubit.dart';
import 'package:p2_address_crud/presentation/cubit/form_validator/form_validator_cubit.dart';
import 'package:p2_address_crud/presentation/pages/address_form/components/country_state_city_input.dart';
import 'package:p2_address_crud/presentation/pages/address_form/components/edomx_cities_dropdown.dart';
import 'package:p2_address_crud/presentation/pages/address_form/components/mx_cities_dropdown.dart';
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
            fontColor: addressUsecase.mainColor.primaryColor,
          ),
          backgroundColor: addressUsecase.mainColor.backgroundColor
        ),
        body: BlocConsumer<PlaceBloc, PlaceState>(
          listener: (context, state) async {
            manageUserLocationResponse(context, state, addressUsecase);
          },
          builder: (context, state) {
            return BlocConsumer<FormValidatorCubit, FormValidatorState>(
              listener: (context, state) {
                manageFormState(id, context, addressUsecase, state, isEditMode);
              },
              builder: (context, state) {
                return BlocConsumer<CitiesDropdownCubit, CitiesDropdownState>(
                  listener: (context, state) {
                    manageCSCDropDownState(addressUsecase, state);
                  },
                  builder: (context, state) {
                    return Container(
                      color: addressUsecase.mainColor.backgroundColor,
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
                                  action: ()async{
                                    bool hasInternet = await InternetConnection().hasInternetAccess;
                                    if(hasInternet){
                                      if(!context.mounted) return;
                                      addressUsecase.determinePosition(context);
                                    }else{
                                      if(!context.mounted) return;
                                      addressUsecase.showAlert(
                                        context, 
                                        Center(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const TitleWidget(
                                                text: "Revisa tu conexión a internet para obtener tu ubicación",
                                                fontColor: Colors.black54,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              MainActionButton(
                                                text: "Ajustes", 
                                                action: (){
                                                  AppSettings.openAppSettings(type: AppSettingsType.wifi);
                                                }
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              MainActionButton(
                                                text: "Cancelar", 
                                                action: () => Navigator.pop(context)
                                              )
                                            ],
                                          ),
                                        ),
                                        250
                                      );
                                    }
                                  }
                                ),
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
                                height: 45,
                                width: double.maxFinite,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            CountryStateCityInput(addressUsecase: addressUsecase),
                            const SizedBox(
                              height: 25,
                            ),
                            addressUsecase.state == "Mexico City" ? 
                              MxCitiesDropDown(addressUsecase: addressUsecase)
                              : addressUsecase.state == "México" ? 
                              EdoMxCitiesDropDown(addressUsecase: addressUsecase)
                              : 
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: InputTextWidget(
                                  controller: addressUsecase.otherCity,
                                  hintText: "Ciudad",
                                  height: 45,
                                  width: double.maxFinite,
                                ),
                              ),
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: InputTextWidget(
                                controller: addressUsecase.address,
                                hintText: "Dirección",
                                height: 45,
                                width: double.maxFinite,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: InputNumberWidget(
                                controller: addressUsecase.zip,
                                hintText: "Código Postal",
                                width: 150,
                                height: 45,
                              )
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            MainActionButton(
                              text: isEditMode ? "Modificar" : "Guardar",
                              action: () {
                                BlocProvider.of<FormValidatorCubit>(context).validateInput(addressUsecase);
                              }
                            ),
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
                                              TitleWidget(
                                                text: "¿Seguro que desea eliminar esta dirección?",
                                                fontColor: addressUsecase.mainColor.primaryColor,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              MainActionButton(
                                                text: "Eliminar",
                                                action: () {
                                                  BlocProvider.of< SqliteManagerBloc>(context).add(
                                                    DeleteElementEvent(addressModel.id, false)
                                                  );
                                                }
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              MainActionButton(
                                                text: "Cancelar",
                                                action: () {
                                                  Navigator.pop(context);
                                                }
                                              )
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
                              text: "Cancelar",
                              action: () => Navigator.pop(context)
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}