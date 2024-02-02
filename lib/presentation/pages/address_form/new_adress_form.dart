import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/domain/form_functions.dart';
import 'package:p2_address_crud/domain/location_functions.dart';
import 'package:p2_address_crud/main.dart';
import 'package:p2_address_crud/presentation/bloc/place/place_bloc.dart';
import 'package:p2_address_crud/presentation/bloc/sqlite_manager/sqlite_manager_bloc.dart';
import 'package:p2_address_crud/presentation/cubit/app_theme_color/app_theme_color_cubit.dart';
import 'package:p2_address_crud/presentation/cubit/cities_drop_down/cities_dropdown_cubit.dart';
import 'package:p2_address_crud/presentation/cubit/form_validator/form_validator_cubit.dart';
import 'package:p2_address_crud/presentation/pages/address_form/components/country_state_city_input.dart';
import 'package:p2_address_crud/presentation/pages/address_form/components/edomx_cities_dropdown.dart';
import 'package:p2_address_crud/presentation/pages/address_form/components/mx_cities_dropdown.dart';
import 'package:p2_address_crud/presentation/pages/shared/input_number_widget.dart';
import 'package:p2_address_crud/presentation/pages/shared/input_text_widget.dart';
import 'package:p2_address_crud/presentation/pages/shared/main_action_button.dart';
import 'package:p2_address_crud/presentation/pages/shared/theme_toogle.dart';
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
              style: mainTheme.textTheme.titleMedium!
                  .copyWith(color: mainTheme.colorScheme.onPrimary),
            ),
            actions: <Widget>[ThemeToogle(usecase: addressUsecase)],
            backgroundColor: mainTheme.colorScheme.secondary),
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
                    return BlocConsumer<AppThemeColorCubit, AppThemeColorState>(
                      listener: (context, state) {
                        if(state is AppThemeColorChanged){
                          usecase.mainColor = state.lightMode ? mainTheme : secondaryTheme;
                          usecase.isLightMode = state.lightMode;
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          color: usecase.mainColor.colorScheme.background,
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
                                        bodyStyle: mainTheme
                                            .textTheme.bodyMedium!
                                            .copyWith(
                                                color: mainTheme
                                                    .colorScheme.onPrimary),
                                        action: () async {
                                          bool hasInternet =
                                              await InternetConnection()
                                                  .hasInternetAccess;
                                          if (hasInternet) {
                                            if (!context.mounted) return;
                                            determinePosition(context);
                                          } else {
                                            if (!context.mounted) return;
                                            addressUsecase.showAlert(
                                                context,
                                                Center(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TitleWidget(
                                                        text:
                                                            "Revisa tu conexión a internet para obtener tu ubicación",
                                                        style: mainTheme
                                                            .textTheme
                                                            .titleMedium!,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      MainActionButton(
                                                          text: "Ajustes",
                                                          bodyStyle: mainTheme
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: mainTheme
                                                                      .colorScheme
                                                                      .onPrimary),
                                                          action: () {
                                                            AppSettings
                                                                .openAppSettings(
                                                                    type: AppSettingsType
                                                                        .wifi);
                                                          }),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      MainActionButton(
                                                          text: "Cerrar",
                                                          bodyStyle: mainTheme
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: mainTheme
                                                                      .colorScheme
                                                                      .onPrimary),
                                                          action: () =>
                                                              Navigator.pop(
                                                                  context))
                                                    ],
                                                  ),
                                                ),
                                                250);
                                          }
                                        }),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InputTextWidget(
                                    adressUsecase: addressUsecase,
                                    controller: addressUsecase.alias,
                                    hintText: "Alias",
                                    height: 45,
                                    width: double.maxFinite,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                CountryStateCityInput(
                                    addressUsecase: addressUsecase),
                                const SizedBox(
                                  height: 25,
                                ),
                                addressUsecase.state == "Mexico City"
                                    ? MxCitiesDropDown(
                                        addressUsecase: addressUsecase)
                                    : addressUsecase.state == "México"
                                        ? EdoMxCitiesDropDown(
                                            addressUsecase: addressUsecase)
                                        : Container(
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: InputTextWidget(
                                              adressUsecase: addressUsecase,
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InputTextWidget(
                                    adressUsecase: addressUsecase,
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: InputNumberWidget(
                                      adressUsecase: addressUsecase,
                                      controller: addressUsecase.zip,
                                      hintText: "Código Postal",
                                      width: 150,
                                      height: 45,
                                    )),
                                const SizedBox(
                                  height: 100,
                                ),
                                MainActionButton(
                                    text: isEditMode ? "Modificar" : "Guardar",
                                    bodyStyle: mainTheme.textTheme.bodyMedium!
                                        .copyWith(
                                            color: mainTheme
                                                .colorScheme.onPrimary),
                                    action: () {
                                      BlocProvider.of<FormValidatorCubit>(
                                              context)
                                          .validateInput(addressUsecase);
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
                                          bodyStyle: mainTheme
                                              .textTheme.bodyMedium!
                                              .copyWith(
                                                  color: mainTheme
                                                      .colorScheme.onPrimary),
                                          action: () {
                                            addressUsecase.showAlert(
                                                context,
                                                Center(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TitleWidget(
                                                        text:
                                                            "¿Seguro que desea eliminar esta dirección?",
                                                        style: mainTheme
                                                            .textTheme
                                                            .titleMedium!,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      MainActionButton(
                                                          text: "Eliminar",
                                                          bodyStyle: mainTheme
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: mainTheme
                                                                      .colorScheme
                                                                      .onPrimary),
                                                          action: () {
                                                            BlocProvider.of<
                                                                        SqliteManagerBloc>(
                                                                    context)
                                                                .add(DeleteElementEvent(
                                                                    addressModel
                                                                        .id,
                                                                    true));
                                                          }),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      MainActionButton(
                                                          text: "Cancelar",
                                                          bodyStyle: mainTheme
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: mainTheme
                                                                      .colorScheme
                                                                      .onPrimary),
                                                          action: () {
                                                            Navigator.pop(
                                                                context);
                                                          })
                                                    ],
                                                  ),
                                                ),
                                                200);
                                          }),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                MainActionButton(
                                    text: "Cancelar",
                                    bodyStyle: mainTheme.textTheme.bodyMedium!
                                        .copyWith(
                                            color: mainTheme
                                                .colorScheme.onPrimary),
                                    action: () => Navigator.pop(context)),
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
            );
          },
        ),
      ),
    );
  }
}
