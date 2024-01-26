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
            'CREATE TABLE IF NOT EXISTS addresses (id INTEGER PRIMARY KEY AUTOINCREMENT, country TEXT, address TEXT, city TEXT, state TEXT, zip TEXT, dateCreated TEXT, dateUpdated TEXT)');
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
        String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
        var databasesPath = await getDatabasesPath();
        String path = join(databasesPath, 'addresses_db.db');
        Database database = await openDatabase(
          path, 
          version: 1,
        );
        database.rawInsert('INSERT INTO addresses(country, address, city, state, zip, dateCreated, dateUpdated) VALUES("${event.addressModel.country}", "${event.addressModel.address}", "${event.addressModel.city}", "${event.addressModel.state}", "${event.addressModel.zip}", "$currentDate", "$currentDate")');
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
  }
}
