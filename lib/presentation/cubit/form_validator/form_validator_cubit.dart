import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';

part 'form_validator_state.dart';

class FormValidatorCubit extends Cubit<FormValidatorState> {
  FormValidatorCubit() : super(FormValidatorInitial());

  void validateInput(AdressUsecase usecase){
    String status = "";
    String type = "";

    if(usecase.zip.text.length != 5){
      status = "Ingresa un código postal válido";
      type= "zip";
    }

    if(usecase.zip.text.isEmpty){
      status = "Ingresa un código postal";
      type= "zip";
    }

    if(usecase.address.text.length < 6){
      status = "Ingresa una dirección válida (min 6 caracteres)";
      type= "address";
    }

    if(usecase.address.text.isEmpty){
      status = "Ingresa una dirección";
      type= "address";
    }

    if(usecase.city.isEmpty){
      status = "Selecciona una ciudad";
      type= "city";
    } 

    if(usecase.state.isEmpty){
      status = "Selecciona un estado";
      type= "state";
    }

    if(usecase.country.isEmpty){
      status = "Selecciona un país";
      type= "country";
    }

    if(usecase.alias.text.isEmpty){
      status = "Agrega un alias para indentificar tu dirección";
      type= "alias";
    }

    

   
   
    if(status.isEmpty){
      emit(AprovedFormState());
    }else{
      emit(InputCheckedState(status, type, DateTime.now()));
    }
  }
}
