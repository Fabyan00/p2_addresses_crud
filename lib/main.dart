import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/presentation/bloc/place/place_bloc.dart';
import 'package:p2_address_crud/presentation/bloc/sqlite_manager/sqlite_manager_bloc.dart';
import 'package:p2_address_crud/presentation/cubit/cities_drop_down/cities_dropdown_cubit.dart';
import 'package:p2_address_crud/presentation/cubit/form_validator/form_validator_cubit.dart';
import 'package:p2_address_crud/presentation/pages/home/home.dart';
import 'package:p2_address_crud/presentation/pages/shared/title_widget.dart';

// SQLITE TUTO
// https://www.dhiwise.com/post/a-walkthrough-with-flutter-databases-sqlite-and-local

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => PlaceBloc()),
      BlocProvider(create: (_) => SqliteManagerBloc()),
      BlocProvider(create: (_) => FormValidatorCubit()),
      BlocProvider(create: (_) => CitiesDropdownCubit()),
    ],
    child:  MyApp()));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: TitleWidget(text: "Tus Direcciones", style: mainTheme.textTheme.titleMedium!,),
          backgroundColor: mainTheme.colorScheme.background
        ),
        body: const Home(),
      )
    );
  }
}
