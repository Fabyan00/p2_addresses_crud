part of 'form_validator_cubit.dart';

class FormValidatorState extends Equatable {
  const FormValidatorState();

  @override
  List<Object> get props => [];
}

final class FormValidatorInitial extends FormValidatorState {}

class AprovedFormState extends FormValidatorState{

  @override 
  List<Object> get props => [];
}

class InputCheckedState extends FormValidatorState{
  final String message;
  final String type;
  final DateTime date;

  const InputCheckedState(this.message, this.type, this.date);

  @override 
  List<Object> get props => [message, date];
}