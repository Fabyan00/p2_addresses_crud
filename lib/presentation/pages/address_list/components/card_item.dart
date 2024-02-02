import 'package:flutter/material.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/pages/address_list/components/card_content.dart';
import 'package:p2_address_crud/presentation/pages/address_list/components/card_details.dart';
import 'package:p2_address_crud/presentation/pages/shared/title_widget.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.index, required this.addressUsecase});
  final int index;
  final AdressUsecase addressUsecase;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        addressUsecase.showAlert(
          context,
          CardDetails(addressUsecase: addressUsecase, addressModel: addressUsecase.data[index]),
          500
        );
      },
      child: Container(
        width: 150,
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: const Color.fromARGB(255, 67, 67, 67),)
        ),
        child: Stack(
          children: [
            Container(
              width: 200,
              height: 32,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: mainTheme.colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomRight:Radius.circular(10.0),
                )
              ),
              child: TitleWidget(text: addressUsecase.data[index].alias.toString(), style: mainTheme.textTheme.titleMedium!.copyWith(color: mainTheme.colorScheme.onPrimary, fontSize: 12),)
            ),
            CardContent(addressUsecase: addressUsecase, addressModel: addressUsecase.data[index],),
          ],
        ),
      ),
    );
  }
}