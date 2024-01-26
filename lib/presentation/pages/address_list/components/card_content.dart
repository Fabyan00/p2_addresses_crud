import 'package:flutter/material.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/pages/address_form/new_adress_form.dart';
import 'package:p2_address_crud/presentation/pages/shared/body_widget.dart';

class CardContent extends StatelessWidget {
  const CardContent({
    super.key,
    required this.date,
    required this.addressUsecase
  });

  final DateTime date;
  final AdressUsecase addressUsecase;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: const BodyWidget(text: "Texto Prueba largo", fontSize: 15,)
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                decoration: BoxDecoration(
                  color: AdressUsecase().mainColor,
                  borderRadius: BorderRadius.circular(10)
                  ),
                child: const Icon(Icons.delete, color: Color.fromARGB(255, 139, 38, 38),)
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BodyWidget(text: "${date.day}/${date.month}/${date.year}", fontSize: 15,),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewAdressForm(addressUsecase: addressUsecase, isEditMode: true,)),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                decoration: BoxDecoration(
                  color: AdressUsecase().mainColor,
                  borderRadius: BorderRadius.circular(10)
                  ),
                child: const Icon(Icons.edit, color: Color.fromARGB(255, 67, 67, 67),)
              ),
            ),
          ],
        )
      ],
    );
  }
}