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
  List<Object> get props => [addressModel];
}

class UpdateElementEvent extends SqliteManagerEvent{
  final AddressModel addressModel;

  const UpdateElementEvent(this.addressModel);

  @override
  List<Object> get props => [addressModel];
}

class DeleteElementEvent extends SqliteManagerEvent{
  final int id;
  final bool isFromModifyScreen;
  const DeleteElementEvent(this.id, this.isFromModifyScreen);
  @override
  List<Object> get props => [id, isFromModifyScreen];
}