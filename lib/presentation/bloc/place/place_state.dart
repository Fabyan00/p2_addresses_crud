part of 'place_bloc.dart';

sealed class PlaceState extends Equatable {
  const PlaceState();
  
  @override
  List<Object> get props => [];
}

final class PlaceInitial extends PlaceState {}

final class LoadingState extends PlaceState{}

final class SucceedSettingPlace extends PlaceState{
  final String country;
  final String state;
  final String city;
  final String address;
  final String zip;

  const SucceedSettingPlace(this.country, this.state, this.city, this.address, this.zip);

  @override 
  List<Object> get props => [country, state, city, address, zip];
}

final class FailedSettingPlace extends PlaceState{
  final String message;
  final DateTime date;

  const FailedSettingPlace(this.message, this.date);

  @override 
  List<Object> get props => [message, date];
}

final class FailedSettingUserLocation extends PlaceState{
  final String message;

  const FailedSettingUserLocation(this.message);

  @override 
  List<Object> get props => [message];
}