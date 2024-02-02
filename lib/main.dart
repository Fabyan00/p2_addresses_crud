import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/presentation/bloc/place/place_bloc.dart';
import 'package:p2_address_crud/presentation/bloc/sqlite_manager/sqlite_manager_bloc.dart';
import 'package:p2_address_crud/presentation/cubit/app_theme_color/app_theme_color_cubit.dart';
import 'package:p2_address_crud/presentation/cubit/cities_drop_down/cities_dropdown_cubit.dart';
import 'package:p2_address_crud/presentation/cubit/form_validator/form_validator_cubit.dart';
import 'package:p2_address_crud/presentation/pages/home/home.dart';
import 'package:p2_address_crud/presentation/pages/shared/theme_toogle.dart';
import 'package:p2_address_crud/presentation/pages/shared/title_widget.dart';

// SQLITE TUTO
// https://www.dhiwise.com/post/a-walkthrough-with-flutter-databases-sqlite-and-local
AdressUsecase usecase = AdressUsecase();

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PlaceBloc()),
        BlocProvider(create: (_) => SqliteManagerBloc()),
        BlocProvider(create: (_) => FormValidatorCubit()),
        BlocProvider(create: (_) => CitiesDropdownCubit()),
        BlocProvider(create: (_) => AppThemeColorCubit()),
      ],
      child: MyApp(
        usecase: usecase,
      )));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.usecase});

  AdressUsecase usecase;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppThemeColorCubit, AppThemeColorState>(
      listener: (context, state) {
        if(state is AppThemeColorChanged){
          usecase.mainColor = state.lightMode ? mainTheme : secondaryTheme;
          usecase.isLightMode = state.lightMode;
        }
      },
      builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                title: TitleWidget(
                    text: "Tus Direcciones",
                    style: mainTheme.textTheme.titleMedium!
                        .copyWith(color: mainTheme.colorScheme.onPrimary)),
                backgroundColor: mainTheme.colorScheme.secondary,
                actions: <Widget>[
                  ThemeToogle(
                    usecase: usecase,
                  )
                ],
              ),
              body: Home(
                adressUsecase: usecase,
              )
            ));
      },
    );
  }
}
