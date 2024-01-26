import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:p2_address_crud/presentation/bloc/place/place_bloc.dart';
import 'package:p2_address_crud/presentation/pages/shared/alert_dialog_widget.dart';

class AdressUsecase{
  var mainColor = const Color.fromARGB(255, 214, 214, 214);

  final TextEditingController _alias = TextEditingController();
  TextEditingController get alias => _alias;

  final TextEditingController _address = TextEditingController();
  TextEditingController get address => _address;

  final TextEditingController _city = TextEditingController();
  TextEditingController get city => _city;

  final TextEditingController _zip = TextEditingController();
  TextEditingController get zip => _zip;

  String validateForm(AdressUsecase usecase){
    if(usecase.address.text.isEmpty || usecase.city.text.isEmpty || usecase.zip.text.isEmpty){
      return "Completa todos los campos!";
    }
    if(usecase.alias.text.isEmpty){
      return "Agrega un alias para identificar tu dirección!";
    }
    return "";
  }


  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if(!context.mounted) return Future.error("No context"); 
      BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent('Location services are disabled.'));
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if(!context.mounted) return Future.error("No context"); 
        BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent('Location permissions are denied.'));
        return Future.error('Location permissions are denied');
      }
    }
  
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. If not, you can use in app message to handle
      if(!context.mounted) return Future.error("No context"); 
      BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent('Location permissions are permanently denied, we cannot request permissions.'));
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } 
    if(!context.mounted) return Future.error("No context"); 
    getUserLocation(context);
    return await Geolocator.getCurrentPosition();
  }

  void getUserLocation(BuildContext context) async {
    try{
      var position = await GeolocatorPlatform.instance.getCurrentPosition();
      if(!context.mounted) return Future.error("No context"); 
      BlocProvider.of<PlaceBloc>(context).add(SetPlaceEvent(position.latitude.toString(), position.longitude.toString(), "here!"));
    }catch(e){
      BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent("Couldn't get user's location, try again latter",));
    }
  }

//   void getPlace() async {
//     List<Placemark> newPlace = await placemarkFromCoordinates(52.2165157, 6.9437819);

//   // this is all you need
//   Placemark placeMark  = newPlace[0]; 
//   String name = placeMark.name!;
//   String subLocality = placeMark.subLocality!;
//   String locality = placeMark.locality!;
//   String administrativeArea = placeMark.administrativeArea!;
//   String postalCode = placeMark.postalCode!;
//   String country = placeMark.country!;
//   String address = "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";
  
//   print(address);

// }

  void showAlert(BuildContext context, Widget content, double height) {
    showDialog(
      context: context,
      builder: (context) => AlertDialogWidget(
        content: content,
        height: height,
      )
    );
  }
}
