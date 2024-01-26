part of 'sqlite_manager_bloc.dart';

sealed class SqliteManagerEvent extends Equatable {
  const SqliteManagerEvent();

  @override
  List<Object> get props => [];
}

class SetLoadingDBEvent extends SqliteManagerEvent{}

class SetDatabaseInitialization extends SqliteManagerEvent{}

class FetchDataEvent extends SqliteManagerEvent{}

class CreateElementEvent extends SqliteManagerEvent{
  final AddressModel addressModel;

  const CreateElementEvent(this.addressModel);

  @override
  List<Object> get props => [];
}