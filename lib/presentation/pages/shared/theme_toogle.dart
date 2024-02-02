import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2_address_crud/data/theme.dart';
import 'package:p2_address_crud/domain/address_usecase.dart';
import 'package:p2_address_crud/main.dart';
import 'package:p2_address_crud/presentation/cubit/app_theme_color/app_theme_color_cubit.dart';

class ThemeToogle extends StatefulWidget {
   ThemeToogle({super.key, required this.usecase});
AdressUsecase usecase;
  @override
  State<ThemeToogle> createState() => _ThemeToogleState();
}

class _ThemeToogleState extends State<ThemeToogle> {
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.light_mode_sharp);
      }
      return const Icon(Icons.dark_mode_rounded);
    },
  );
  final MaterialStateProperty<Color?> trackColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return mainTheme.colorScheme.background;
      }
      return mainTheme.colorScheme.surface;
    },
  );
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.usecase.isLightMode, 
      thumbIcon: thumbIcon,
      trackColor: trackColor,
      onChanged: (bool value){
        setState(() {
          widget.usecase.isLightMode = value;
          BlocProvider.of<AppThemeColorCubit>(context).changeAppTheme(value);
        });
      }
    );
  }
}