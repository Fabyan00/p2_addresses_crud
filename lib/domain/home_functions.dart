import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/bloc/sqlite_manager/sqlite_manager_bloc.dart';
import 'package:p2_address_crud/presentation/pages/shared/main_action_button.dart';
import 'package:p2_address_crud/presentation/pages/shared/title_widget.dart';

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
  }
  if(state is SucceedInitializingDataBaseState){
    Navigator.pop(context);
    adressUsecase.data = state.modelList;
  }

  if(state is SucceedCreatingElementState){
    adressUsecase.cleanForm();
    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    adressUsecase.showAlert(
      context, 
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(text: state.message, fontColor: adressUsecase.mainColor.primaryColor,),
            const SizedBox(height: 10,),
            MainActionButton(
              text: "Aceptar", 
              action: (){
              Navigator.pop(context);
            })
          ],
        ),
      ), 
      200
    );
    BlocProvider.of<SqliteManagerBloc>(context).add(FetchDataEvent());
  }

  if(state is SucceedFetchingDataState){
    Navigator.pop(context);
    adressUsecase.data = state.modelList;
  } 

  if(state is SucceedUpdatingElementState){
    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    adressUsecase.showAlert(
      context, 
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(text: state.message, fontColor: adressUsecase.mainColor.primaryColor,),
            const SizedBox(height: 10,),
            MainActionButton(
              text: "Aceptar", 
              action: (){
              Navigator.pop(context);
            })
          ],
        ),
      ), 
      200
    );
    BlocProvider.of<SqliteManagerBloc>(context).add(FetchDataEvent());
  }

  if(state is SucceedDeletingElementState){
    adressUsecase.cleanForm();
    if(state.isFromModifyScreen){
      Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    }else{
      Navigator.pop(context);
      Navigator.pop(context);
    }
    adressUsecase.showAlert(
      context, 
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(text: state.message, fontColor: adressUsecase.mainColor.primaryColor),
            const SizedBox(height: 10,),
            MainActionButton(
              text: "Aceptar", 
              action: (){
              Navigator.pop(context);
            })
          ],
        ),
      ), 
      200
    );
    BlocProvider.of<SqliteManagerBloc>(context).add(FetchDataEvent());
  }

  if(state is FailedInitializingDataBaseState){
    adressUsecase.showAlert(
      context, 
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(text: state.message, fontColor: adressUsecase.mainColor.primaryColor),
            const SizedBox(height: 10,),
            MainActionButton(
              text: "Aceptar", 
              action: (){
              SystemNavigator.pop();
            })
          ],
        ),
      ), 
      200
    );
  }
}