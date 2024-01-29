import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/presentation/bloc/place/place_bloc.dart';
import 'package:p2_address_crud/presentation/pages/shared/alert_dialog_widget.dart';

class AdressUsecase{
  var mainColor = const Color.fromARGB(255, 214, 214, 214);

  final TextEditingController _alias = TextEditingController();
  TextEditingController get alias => _alias;

  final TextEditingController _address = TextEditingController();
  TextEditingController get address => _address;

  final TextEditingController _zip = TextEditingController();
  TextEditingController get zip => _zip;

  List<AddressModel> data = [];

  String country = "Mexico";
  String state = "";
  String city = "";

  String validateForm(AdressUsecase usecase){
    if(usecase.address.text.isEmpty || usecase.country.isEmpty || usecase.zip.text.isEmpty){
      return "Completa todos los campos!";
    }
    if(usecase.alias.text.isEmpty){
      return "Agrega un alias para identificar tu dirección!";
    }
    if(usecase.zip.text.length != 5){
      return "Código postal invalido, revisa e intenta de nuevo";
    }
    if(usecase.address.text.length < 6){
      return "Agrega una dirección válida";
    }
    return "";
  }

  void cleanForm(){
    alias.clear();
    address.clear();
    zip.clear();
    country = "";
    state = "";
    city = "";
  }

  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if(!context.mounted) return Future.error("No context"); 
      BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent('Location services are disabled.'));
      return Future.error('La ubicación está desactivada. Ve a configuración para modificarlo.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if(!context.mounted) return Future.error("No context"); 
        BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent('Location permissions are denied.'));
        return Future.error('Los permisos de ubicación fueron denegados. Ve a configuración para modificarlo.');
      }
    }
  
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. If not, you can use in app message to handle
      if(!context.mounted) return Future.error("No context"); 
      BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent('Location permissions are permanently denied, we cannot request permissions.'));
      return Future.error('Los permisos de ubicación fueron denegados temporalmente. Ve a configuración para modificarlo.');
    } 
    if(!context.mounted) return Future.error("No context"); 
    getLocationInfo(context);
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getLocationInfo(BuildContext context) async {    
    BlocProvider.of<PlaceBloc>(context).add(SetLoadingEvent());
  try {
    // Get the current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    // Get the address details using reverse geocoding
    List placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    // Extract address details
    String country = placemarks[0].country ?? '';
    String state = placemarks[0].administrativeArea ?? '';
    String city = placemarks[0].locality ?? '';
    String address = placemarks[0].street ?? '';
    String zip = placemarks[0].postalCode ?? '';

    print(country);
    print(state);
    print(city);

    if(!context.mounted) return Future.error("No context"); 
    BlocProvider.of<PlaceBloc>(context).add(
      SetPlaceEvent(
        country, state, city, address, zip
      )
    );
  } catch (e) {
    BlocProvider.of<PlaceBloc>(context).add(SetErrorPlaceEvent("No pudimos obtener información de ubicación, intentalo de nuevo más tarde.",));
  }
}

  void showAlert(BuildContext context, Widget content, double height) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialogWidget(
        content: content,
        height: height,
      )
    );
  }
}
