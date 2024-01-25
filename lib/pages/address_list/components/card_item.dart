import 'package:flutter/material.dart';
import 'package:p2_address_crud/pages/shared/body_widget.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    return Dismissible(
      key:Key(id.toString()),
      onDismissed: (direction){
        //TODO: remove at index from list
      } ,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 85, 
        width: 150,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 67, 67, 67),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: const BodyWidget(text: "Texto Prueba largo", fontSize: 15,)
            ),
            Container(
              alignment: Alignment.centerRight,
               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BodyWidget(text: "${date.day}/${date.month}/${date.year}", fontSize: 15,),
            )
          ],
        ),
      ),
    );
  }
}