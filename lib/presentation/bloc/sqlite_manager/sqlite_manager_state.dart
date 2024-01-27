part of 'sqlite_manager_bloc.dart';

class SqliteManagerState extends Equatable {
  const SqliteManagerState();
  
  @override
  List<Object> get props => [];
}

class SqliteManagerInitial extends SqliteManagerState {}

class LoadingDBState extends SqliteManagerState{
  final String message;
  final DateTime date;

  const LoadingDBState(this.message, this.date);

  @override 
  List<Object> get props => [message, date];
}

class SucceedInitializingDataBaseState extends SqliteManagerState{
  final List<AddressModel> modelList;
  final String message;
  final DateTime date;

  const SucceedInitializingDataBaseState(this.message, this.date, this.modelList);

  @override 
  List<Object> get props => [message, date, modelList];
}

class FailedInitializingDataBaseState extends SqliteManagerState{
  final String message;
  final DateTime date;

  const FailedInitializingDataBaseState(this.message, this.date);

  @override 
  List<Object> get props => [message, date];
}

class SucceedFetchingDataState extends SqliteManagerState{
  final List<AddressModel> modelList;
  final DateTime date;

  const SucceedFetchingDataState(this.modelList, this.date);

  @override 
  List<Object> get props => [modelList, date];
}

class SucceedCreatingElementState extends SqliteManagerState{
  final String message;
  final DateTime date;

  const SucceedCreatingElementState(this.message, this.date);

  @override 
  List<Object> get props => [message, date];
}

class SucceedUpdatingElementState extends SqliteManagerState{
  final String message;
  final DateTime date;

  const SucceedUpdatingElementState(this.message, this.date);

  @override 
  List<Object> get props => [message, date];
}

class SucceedDeletingElementState extends SqliteManagerState{
  final String message;
  final DateTime date;
  final bool isFromModifyScreen;

  const SucceedDeletingElementState(this.message, this.date, this.isFromModifyScreen);

  @override 
  List<Object> get props => [message, date, isFromModifyScreen];
}