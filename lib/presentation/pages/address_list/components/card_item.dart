import 'package:flutter/material.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/pages/address_list/components/card_content.dart';
import 'package:p2_address_crud/presentation/pages/address_list/components/card_details.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.index, required this.addressUsecase});
  final int index;
  final AdressUsecase addressUsecase;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key:Key(index.toString()),
      onDismissed: (direction){
        //TODO: remove at index from list
      } ,
      child: InkWell(
        onTap: () {
          addressUsecase.showAlert(
            context,
            CardDetails(addressUsecase: addressUsecase, addressModel: addressUsecase.data[index]),
            500
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 85, 
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: const Color.fromARGB(255, 67, 67, 67),)
          ),
          child: CardContent(addressUsecase: addressUsecase, addressModel: addressUsecase.data[index],),
        ),
      ),
    );
  }
}