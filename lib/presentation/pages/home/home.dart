import 'package:flutter/material.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/pages/address_form/new_adress_form.dart';
import 'package:p2_address_crud/presentation/pages/address_list/address_list.dart';
import 'package:p2_address_crud/presentation/pages/shared/main_action_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AdressUsecase adressUsecase = AdressUsecase();
    return Container(
      color: const Color.fromARGB(255, 214, 214, 214),
      height: double.maxFinite,
      width: double.maxFinite,
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10,),
          AdressList(addressUsecase: adressUsecase,),
          const SizedBox(height: 10,),
          MainActionButton(
            text: "Nueva Dirección", 
            action: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewAdressForm(addressUsecase: adressUsecase, isEditMode: false,)),
              );
            }
          )
        ],
      ), 
    );
  }
}