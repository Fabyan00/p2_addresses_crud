import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:p2_address_crud/presentation/bloc/place/place_bloc.dart';

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
    BlocProvider.of<PlaceBloc>(context).add(SetErrorPlaceEvent("No pudimos obtener información de ubicación. Intentalo de nuevo mas tarde",));
  }
}