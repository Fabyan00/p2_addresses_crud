import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2_address_crud/data/models/address_model.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/domain/home_functions.dart';
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
  void initState(){
    BlocProvider.of<SqliteManagerBloc>(context).add(SetDatabaseInitialization());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AdressUsecase adressUsecase = AdressUsecase();
    AddressModel addressModel = const AddressModel(id: 0, alias: "", country: "", state: "", city: "", address: "", zip: "", dateCreated: "", dateUpdated: "");
    return BlocConsumer<SqliteManagerBloc, SqliteManagerState>(
      listener: (context, state) {
        manageDataBaseResponse(context, state, adressUsecase);
      },
      builder: (context, state) {
        return Container(
          color: adressUsecase.mainColor.backgroundColor,
          height: double.maxFinite,
          width: double.maxFinite,
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<SqliteManagerBloc>(context).add(FetchDataEvent());
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                adressUsecase.data.isEmpty ?
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(height: 200,),
                      TitleWidget(text: "No has guardado ninguna dirección aún", fontColor: adressUsecase.mainColor.primaryColor, fontSize: 15,),
                      const SizedBox(height: 25,),
                      const Icon(Icons.sentiment_neutral_outlined, size: 50,),
                      const SizedBox(height: 250,)
                    ]
                  ),
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
                    adressUsecase.cleanForm();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewAdressForm(
                          addressModel: addressModel,
                          addressUsecase: adressUsecase,
                          isEditMode: false,
                        )
                      ),
                    );
                  }
                )
              ],
            ),
          ),
        );
      },
    );
  }
}