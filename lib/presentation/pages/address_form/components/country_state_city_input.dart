import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/cubit/cities_drop_down/cities_dropdown_cubit.dart';

class CountryStateCityInput extends StatelessWidget {
  const CountryStateCityInput({super.key, required this.addressUsecase});

  final AdressUsecase addressUsecase;

  @override
  Widget build(BuildContext context) {
     return Container(
       margin: const EdgeInsets.symmetric(horizontal: 10),
      //  decoration: inputFormDecoration,
       child: CSCPicker(
         selectedItemStyle: mainTheme.textTheme.bodyMedium!.copyWith(fontSize: 15),
         currentCountry: addressUsecase.country,
         currentState: "Mexico City",
         flagState: CountryFlag.DISABLE,
         countrySearchPlaceholder: "Buscar País",
         stateSearchPlaceholder: "Buscar Estado",
         showStates: addressUsecase.country == "Mexico",
         showCities: false,
         countryDropdownLabel: addressUsecase.country.isEmpty ? "País" : addressUsecase.country,
         stateDropdownLabel: addressUsecase.state.isEmpty ? "Estado" : addressUsecase.state,
         dropdownDecoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
         ),
         onCountryChanged: (value) {
           if(value != null){
            addressUsecase.country = value;
            if(addressUsecase.country != "Mexico"){
              addressUsecase.state = "";
              addressUsecase.city = "";
            }
           }
         },
         onStateChanged:(value) {
          if(value != null){
            addressUsecase.state = value;
            BlocProvider.of<CitiesDropdownCubit>(context).selectState(value!, addressUsecase);
          }else{
             BlocProvider.of<CitiesDropdownCubit>(context).selectState("", addressUsecase);
          }
         },
         onCityChanged:(value) {
          if(value != null){
          }
         },
       )
     );
  }
}