import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';

class CountryStateCityInput extends StatelessWidget {
  const CountryStateCityInput({super.key, required this.addressUsecase});

  final AdressUsecase addressUsecase;

  @override
  Widget build(BuildContext context) {
     return Container(
       margin: const EdgeInsets.symmetric(horizontal: 10),
       child: CSCPicker(
         selectedItemStyle: GoogleFonts.raleway(
         textStyle: const TextStyle(
           fontSize: 15,)  
         ),
         currentCountry: "Mexico",
         currentState: "Mexico City",
         flagState: CountryFlag.DISABLE,
         countrySearchPlaceholder: "Buscar País",
         stateSearchPlaceholder: "Buscar Estado",
         citySearchPlaceholder: "Buscar Ciudad",
         countryDropdownLabel: addressUsecase.country.isEmpty ? "País" : addressUsecase.country,
         stateDropdownLabel: addressUsecase.state.isEmpty ? "Estado" : addressUsecase.state,
         cityDropdownLabel: addressUsecase.city.isEmpty ? "Ciudad" : addressUsecase.city,
         dropdownDecoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
         ),
         onCountryChanged: (value) {
           if(value != null){
             addressUsecase.country = value;
           }else{
             addressUsecase.country = "";
           }
         },
         onStateChanged:(value) {
           if(value != null){
             addressUsecase.state = value;
           }else{
             addressUsecase.state = "";
           }
         },
         onCityChanged:(value) {
           if(value != null){
             addressUsecase.city = value;
           }else{
             addressUsecase.city = "";
           }
         },
       )
     );
  }
}