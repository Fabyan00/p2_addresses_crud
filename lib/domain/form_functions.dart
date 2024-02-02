import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/bloc/place/place_bloc.dart';
import 'package:p2_address_crud/presentation/bloc/sqlite_manager/sqlite_manager_bloc.dart';
import 'package:p2_address_crud/presentation/cubit/cities_drop_down/cities_dropdown_cubit.dart';
import 'package:p2_address_crud/presentation/cubit/form_validator/form_validator_cubit.dart';
import 'package:p2_address_crud/presentation/pages/shared/main_action_button.dart';
import 'package:p2_address_crud/presentation/pages/shared/title_widget.dart';

void manageFormState(int id, BuildContext context, AdressUsecase addressUsecase, FormValidatorState state, bool isEditMode){
  if (state is InputCheckedState) {
    if (state.message.isNotEmpty) {
      addressUsecase.showAlert(
          context,
          Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleWidget(
                text: state.message,
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
    }
  } else if (state is AprovedFormState) {
    createAddress(context, addressUsecase, id, isEditMode);
  }
}

void manageCSCDropDownState(AdressUsecase addressUsecase, CitiesDropdownState state){
  if(state is CountryChangedState){
    addressUsecase.country = state.country;
  }
  if(state is StateChangedState){
    addressUsecase.state = state.state;
    if(addressUsecase.state == "Mexico City"){
      addressUsecase.city = addressUsecase.mxCitiesList.first;
    }else if(addressUsecase.state == "México"){
      addressUsecase.city = addressUsecase.edoMxCitiesList.first;
    }
  }
  if(state is MxCityChangedState ){
    addressUsecase.city = state.city;
  }
}

void createAddress(BuildContext context, AdressUsecase addressUsecase, int id, bool isEditMode) {
  AddressModel model = AddressModel(
    id: id,
    alias: addressUsecase.alias.text,
    country: addressUsecase.country,
    address: addressUsecase.address.text,
    city: addressUsecase.country != "Mexico" ? addressUsecase.otherCity.text : addressUsecase.city,
    state: addressUsecase.country != "Mexico" ? "" : addressUsecase.state,
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

void manageUserLocationResponse(BuildContext context, PlaceState state, AdressUsecase adressUsecase) {
  if (state is LoadingState) {
    adressUsecase.showAlert(
      context,
      const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(
              text: "Obteniendo ubicación. . .",
              fontColor: Colors.black54,
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              color: Colors.black54,
            ),
          ],
        ),
      ),
      200
    );
  }

  if (state is SucceedSettingPlace) {
    Navigator.pop(context);
    //Just for the specific csc package
    adressUsecase.country = state.country;
    adressUsecase.state = state.state == "Ciudad de México" ? "Mexico City" : state.state;
    adressUsecase.city = state.city;
    adressUsecase.address.text = state.address;
    adressUsecase.zip.text = state.zip;
  }

  if (state is FailedSettingPlace) {
    Navigator.pop(context);
    adressUsecase.showAlert(
      context,
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(
              text: state.message,
              fontSize: 20,
              fontColor: Colors.black54,
            ),
            const SizedBox(
              height: 10,
            ),
            MainActionButton(
              text: "Ajustes",
              action: () {
                Navigator.pop(context);
                AppSettings.openAppSettings(type: AppSettingsType.location);
              },
            ),
            const SizedBox(height: 10,),
            MainActionButton(
              text: "Cancelar",
              action: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      ),
      250
    );
  }

  if (state is FailedSettingUserLocation) {
    Navigator.pop(context);
    adressUsecase.showAlert(
      context,
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(
              text: state.message,
              fontSize: 20,
              fontColor: Colors.black54,
            ),
            const SizedBox(
              height: 10,
            ),
            MainActionButton(
              text: "Ajustes",
              action: () {
                Navigator.pop(context);
                AppSettings.openAppSettings(type: AppSettingsType.location);
              },
            ),
            const SizedBox(height: 10,),
            MainActionButton(
              text: "Cancelar",
              action: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      ),
      250
    );
  }
}