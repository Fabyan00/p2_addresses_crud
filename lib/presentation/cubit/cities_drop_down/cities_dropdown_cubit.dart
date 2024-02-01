import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';

part 'cities_dropdown_state.dart';

class CitiesDropdownCubit extends Cubit<CitiesDropdownState> {
  CitiesDropdownCubit() : super(CitiesDropdownInitial());

  void selectCountry(String country, AdressUsecase usecase){
    emit(CountryChangedState(country, DateTime.now()));
  }

  void selectState(String state, AdressUsecase usecase){
    emit(StateChangedState(state, DateTime.now()));
  }

  void changeMxCities(String city, AdressUsecase usecase){
    emit(MxCityChangedState(city, DateTime.now()));
  }
}
