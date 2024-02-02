import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/cubit/cities_drop_down/cities_dropdown_cubit.dart';

class MxCitiesDropDown extends StatelessWidget {
  MxCitiesDropDown({Key? key, required this.addressUsecase});
  final AdressUsecase addressUsecase;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Column(
        children: [
          DropdownSearch<String>(
            selectedItem: addressUsecase.city,
            
            onChanged: (newValue) {
              BlocProvider.of<CitiesDropdownCubit>(context).changeMxCities(newValue!, addressUsecase);
            },
            items: addressUsecase.mxCitiesList,
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color.fromARGB(255, 226, 224, 224),
                contentPadding: EdgeInsets.symmetric(horizontal: 2)
              )
            )
          ),
        ],
      ),
    );
  }
}