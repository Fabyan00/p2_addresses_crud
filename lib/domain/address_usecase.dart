import 'package:flutter/material.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/presentation/pages/shared/alert_dialog_widget.dart';

class AdressUsecase{
  bool hasInternet = false;
  bool isLightMode = true;
  var mainColor = mainTheme;

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
