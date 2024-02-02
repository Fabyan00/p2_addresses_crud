import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_theme_color_state.dart';

class AppThemeColorCubit extends Cubit<AppThemeColorState> {
  AppThemeColorCubit() : super(AppThemeColorInitial());

  void changeAppTheme(bool lightMode){
    emit(AppThemeColorChanged(DateTime.now(), lightMode));
  }
}
