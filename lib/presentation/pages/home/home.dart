import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/bloc/sqlite_manager/sqlite_manager_bloc.dart';
import 'package:p2_address_crud/presentation/pages/address_form/new_adress_form.dart';
import 'package:p2_address_crud/presentation/pages/address_list/address_list.dart';
import 'package:p2_address_crud/presentation/pages/shared/main_action_button.dart';
import 'package:p2_address_crud/presentation/pages/shared/title_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    BlocProvider.of<SqliteManagerBloc>(context).add(SetDatabaseInitialization());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AdressUsecase adressUsecase = AdressUsecase();
    return BlocConsumer<SqliteManagerBloc, SqliteManagerState>(
      listener: (context, state) {
        manageDataBaseResponse(context, state, adressUsecase);
      },
      builder: (context, state) {
        return Container(
          color: const Color.fromARGB(255, 214, 214, 214),
          height: double.maxFinite,
          width: double.maxFinite,
          child: RefreshIndicator(
            onRefresh: () async {
              print("refresh");
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                adressUsecase.data.isEmpty ?
                const Column(
                  children: [
                    SizedBox(height: 200,),
                    TitleWidget(text: "No has guardado ninguna dirección aún", fontColor: Colors.black, fontSize: 15,),
                    SizedBox(height: 25,),
                    Icon(Icons.sentiment_neutral_outlined, size: 50,),
                    SizedBox(height: 250,)
                  ]
                )
                : 
                AdressList(
                  addressUsecase: adressUsecase,
                ),
                const SizedBox(
                  height: 20,
                ),
                MainActionButton(
                    text: "Nueva Dirección",
                    action: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewAdressForm(
                                  addressUsecase: adressUsecase,
                                  isEditMode: false,
                                )),
                      );
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}

void manageDataBaseResponse(BuildContext context, SqliteManagerState state, AdressUsecase adressUsecase){
  if(state is LoadingDBState){
    adressUsecase.showAlert(
      context,
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(text: state.message, fontColor: Colors.black54,),
            const SizedBox(height: 10,),
            const CircularProgressIndicator(color: Colors.black54,),
          ],
        ),
      ),
      200
    );
    print("Loading!");
  }else if(state is SucceedInitializingDataBaseState){
    Navigator.pop(context);
    adressUsecase.data = state.modelList;
    print("SUCCESS");
    print(state.message);
  }else if(state is SucceedFetchingDataState){
    adressUsecase.data = state.modelList;
  }else if(state is FailedInitializingDataBaseState){
    print("ERROR");
    print(state.message);
  }
}