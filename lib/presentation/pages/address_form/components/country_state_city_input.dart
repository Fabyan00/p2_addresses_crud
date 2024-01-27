import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';

class CountryStateInput extends StatefulWidget {
  CountryStateInput({super.key, required this.addressUsecase});

  AdressUsecase addressUsecase;

  @override
  State<CountryStateInput> createState() => _CountryStateInputState();
}

class _CountryStateInputState extends State<CountryStateInput> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: CSCPicker(
        selectedItemStyle: GoogleFonts.raleway(
        textStyle: const TextStyle(
          fontSize: 15,)  
      ),
        countryDropdownLabel: widget.addressUsecase.country.isEmpty ? "País" : widget.addressUsecase.country,
        stateDropdownLabel: widget.addressUsecase.state.isEmpty ? "Estado" : widget.addressUsecase.state,
        cityDropdownLabel: widget.addressUsecase.city.isEmpty ? "Ciudad" : widget.addressUsecase.city,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        onCountryChanged: (value) {
          if(value != null){
            widget.addressUsecase.country = value;
          }else{
            widget.addressUsecase.country = "";
          }
        },
        onStateChanged:(value) {
          if(value != null){
            widget.addressUsecase.state = value;
          }else{
            widget.addressUsecase.state = "";
          }
        },
        onCityChanged:(value) {
          if(value != null){
            widget.addressUsecase.city = value;
          }else{
            widget.addressUsecase.city = "";
          }
        },
      ),
    );
  }
}