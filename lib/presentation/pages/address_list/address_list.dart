import 'package:flutter/material.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/pages/address_list/components/card_item.dart';

class AdressList extends StatelessWidget {
  const AdressList({
    super.key,
    required this.addressUsecase
  });

  final AdressUsecase addressUsecase;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 595,
      width: double.maxFinite,
      child: ListView.builder(itemCount: 5, itemBuilder:(context, index) => CardItem(id: index, addressUsecase: addressUsecase,)),
    );
  }
}