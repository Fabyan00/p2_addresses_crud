import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

part 'sqlite_manager_event.dart';
part 'sqlite_manager_state.dart';

class SqliteManagerBloc extends Bloc<SqliteManagerEvent, SqliteManagerState> {
  SqliteManagerBloc() : super(SqliteManagerInitial()){

    on<SetDatabaseInitialization>((event, emit) async {
      emit(LoadingDBState("Bienvenido. . .", DateTime.now()));
      try{
        var databasesPath = await getDatabasesPath();
        String path = join(databasesPath, 'addresses_db.db');
        Database database = await openDatabase(
          path, 
          version: 1,
          onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE IF NOT EXISTS addresses (id INTEGER PRIMARY KEY AUTOINCREMENT, alias TEXT, country TEXT, state TEXT, city TEXT, address TEXT, zip TEXT, dateCreated TEXT, dateUpdated TEXT)');
          }
        );
        List<Map<String, dynamic>> list = await database.rawQuery('SELECT * FROM addresses');
        List<AddressModel> modelList = transformResponse(list);
        database.close();
        emit(SucceedInitializingDataBaseState("Success", DateTime.now(), modelList));
        
      }catch(e){
        print("Error en base de datos: ${e.toString}");
        emit(FailedInitializingDataBaseState(e.toString(), DateTime.now()));
      }
    });

    on<CreateElementEvent>((event, emit) async {
      emit(LoadingDBState("Guardando Dirección. . .", DateTime.now()));
      try{
        String currentDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now().toLocal());
        var databasesPath = await getDatabasesPath();
        String path = join(databasesPath, 'addresses_db.db');
        Database database = await openDatabase(
          path, 
          version: 1,
        );
        database.rawInsert('INSERT INTO addresses(alias, country, state, city, address, zip, dateCreated, dateUpdated) VALUES("${event.addressModel.alias}", "${event.addressModel.country}", "${event.addressModel.state}", "${event.addressModel.city}", "${event.addressModel.address}", "${event.addressModel.zip}", "$currentDate", "$currentDate")');
        database.close();
        emit(SucceedCreatingElementState("Dirección Guardada!", DateTime.now()));
        
      }catch(e){
        print("Error en base de datos: ${e.toString}");
        emit(FailedInitializingDataBaseState("No pudimos guardar la dirección: ${e.toString()}", DateTime.now()));
      }
    }); 

     on<FetchDataEvent>((event, emit) async {
      emit(LoadingDBState("Cargando. . .", DateTime.now()));
      try{
        var databasesPath = await getDatabasesPath();
        String path = join(databasesPath, 'addresses_db.db');
        Database database = await openDatabase(
          path, 
          version: 1
        );
        List<Map<String, dynamic>> list = await database.rawQuery('SELECT * FROM addresses');
        List<AddressModel> modelList = transformResponse(list);
        database.close();
        emit(SucceedFetchingDataState(modelList, DateTime.now()));
        
      }catch(e){
        print("Error en base de datos: ${e.toString}");
        emit(FailedInitializingDataBaseState("No pudimos cargar los datos: ${e.toString()}", DateTime.now()));
      }
    });

    on<UpdateElementEvent>((event, emit) async {
      emit(LoadingDBState("Actualizando Dirección. . .", DateTime.now()));
      try{
        String currentDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now().toLocal());
        var databasesPath = await getDatabasesPath();
        String path = join(databasesPath, 'addresses_db.db');
        Database database = await openDatabase(
          path, 
          version: 1,
        );
        database.rawUpdate('UPDATE addresses SET alias="${event.addressModel.alias}", country="${event.addressModel.country}", state="${event.addressModel.state}", city="${event.addressModel.city}", address="${event.addressModel.address}", zip="${event.addressModel.zip}", dateUpdated="$currentDate" WHERE id=${event.addressModel.id}');
        database.close();
        emit(SucceedUpdatingElementState("Dirección Actualizada!", DateTime.now()));
        
      }catch(e){
        print("Error en base de datos: ${e.toString}");
        emit(FailedInitializingDataBaseState("No pudimos actualizar la dirección: ${e.toString()}", DateTime.now()));
      }
    }); 

    on<DeleteElementEvent>((event, emit) async {
      emit(LoadingDBState("Borrando Dirección. . .", DateTime.now()));
      try{
        var databasesPath = await getDatabasesPath();
        String path = join(databasesPath, 'addresses_db.db');
        Database database = await openDatabase(
          path, 
          version: 1,
        );
        database.rawDelete('DELETE FROM addresses WHERE id=${event.id}');
        database.close();
        emit(SucceedDeletingElementState("Dirección Borrada!", DateTime.now(), event.isFromModifyScreen));
        
      }catch(e){
        print("Error en base de datos: ${e.toString}");
        emit(FailedInitializingDataBaseState("No pudimos eliminar la dirección: ${e.toString()}", DateTime.now()));
      }
    }); 
  }
}
