part of 'cities_dropdown_cubit.dart';

class CitiesDropdownState extends Equatable {
  const CitiesDropdownState();

  @override
  List<Object> get props => [];
}

class CitiesDropdownInitial extends CitiesDropdownState {}

class CountryChangedState extends CitiesDropdownState{
  final String country;
  final DateTime date;
  const CountryChangedState(this.country, this.date);
  @override 
  List<Object> get props => [country, date];
}

class StateChangedState extends CitiesDropdownState{
  final String state;
  final DateTime date;
  const StateChangedState(this.state, this.date);
  @override 
  List<Object> get props => [state, date];
}

class MxCityChangedState extends CitiesDropdownState{
  final String city;
  final DateTime date;
  const MxCityChangedState(this.city, this.date);
  @override 
  List<Object> get props => [city, date];
}
