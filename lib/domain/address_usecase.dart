import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/presentation/bloc/place/place_bloc.dart';
import 'package:p2_address_crud/presentation/pages/shared/alert_dialog_widget.dart';

class AdressUsecase{
  var mainColor = lightTheme;
  bool hasInternet = false;

  final TextEditingController _alias = TextEditingController();
  TextEditingController get alias => _alias;

  final TextEditingController _address = TextEditingController();
  TextEditingController get address => _address;

  final TextEditingController _zip = TextEditingController();
  TextEditingController get zip => _zip;

  final TextEditingController _otherCity = TextEditingController();
  TextEditingController get otherCity => _otherCity;

  List<AddressModel> data = [];

  List<String> mxCitiesList = [
    "Alvaro Obregon", "Azcapotzalco", "Benito Juarez", "Coyoacan", "Cuajimalpa de Morelos", "Cuauhtemoc", "Gustavo A. Madero", 
    "Iztacalco", "Iztapalapa", "Magdalena Contreras", "Miguel Hidalgo", "Milpa Alta", "Tlahuac", "Tlalpan", "Venustiano Carranza",
    "Xochimilco"
  ];

  List<String> edoMxCitiesList = [
    "Acambay de Ruíz Castañeda", "Acolman", "Aculco", "Almoloya de Alquisiras", "Almoloya de Juárez", "Almoloya del Río", "Amanalco", "Amatepec" 
    "Amecameca", "Apaxco", "Atenco", "Atizapán", "Atizapán de Zaragoza", "Atlacomulco", "Atlautla", "Axapusco", "Ayapango", "Calimaya", "Capulhuac",
    "Coacalco de Berriozábal", "Coatepec Harinas", "Cocotitlán", "Coyotepec", "Cuautitlán", "Chalco", "Chapa de Mota", "Chapultepec", "Chiautla",
    "Chicoloapan", "Chiconcuac", "Chimalhuacán", "Donato Guerra", "Ecatepec de Morelos", "Ecatzingo", "Huehuetoca", "Hueypoxtla", "Huixquilucan", 
    "Ixtapaluca", "Ixtapan de la Sal", "Jaltenco", "Jilotepec", "Jilotzingo", "Jocotitlán", "Lerma", "Melchor Ocampo", "Metepec", "Morelos", "Naucalpan de Juárez", 
    "Nezahualcóyotl", "Nicolás Romero", "Ocoyoacac", "La Paz", "Polotitlán", "San Felipe del Progreso", "San Martín de las Pirámides", "San Mateo Atenco", 
    "Santo Tomás", "Tecámac", "Tejupilco", "Temascalapa", "Temascalcingo", "Teoloyucan", "Teotihuacán", "Tepotzotlán", "Tequixquiac", "Texcoco", 
    "Tezoyuca", "Tlalnepantla de Baz", "Toluca", "Tultepec", "Tultitlán", "Valle de Bravo", "Villa del Carbón", "Villa Guerrero", "Villa Victoria", "Zumpango", 
    "Cuautitlán Izcalli"
  ];

  String country = "Mexico";
  String state = "Mexico City";
  String city = "Alvaro Obregon";

  void cleanForm(){
    alias.clear();
    address.clear();
    zip.clear();
    country = "Mexico";
    state = "Mexico City";
    city = "Alvaro Obregon";
  }

  void determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if(!context.mounted) return Future.error("No context"); 
      BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent('La ubicación está desactivada. Ve a configuración para modificarlo.'));
      return Future.error('La ubicación está desactivada. Ve a configuración para modificarlo.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if(!context.mounted) return Future.error("No context"); 
        BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent('Los permisos de ubicación fueron denegados. Ve a configuración para modificarlo.'));
        return Future.error('Los permisos de ubicación fueron denegados. Ve a configuración para modificarlo.');
      }
    }
  
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. If not, you can use in app message to handle
      if(!context.mounted) return Future.error("No context"); 
      BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent('Los permisos de ubicación fueron denegados temporalmente. Ve a configuración para modificarlo.'));
      return Future.error('Los permisos de ubicación fueron denegados temporalmente. Ve a configuración para modificarlo.');
    } 
    if(!context.mounted) return Future.error("No context"); 
    getLocationInfo(context);
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

      if(!context.mounted) return Future.error("No context"); 
        BlocProvider.of<PlaceBloc>(context).add(SetPlaceEvent(country, state, city, address, zip)
      );
  } catch (e) {
    BlocProvider.of<PlaceBloc>(context).add(SetErrorPlaceEvent("No pudimos obtener información de ubicación: ${e}",));
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
