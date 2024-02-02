part of 'app_theme_color_cubit.dart';

class AppThemeColorState extends Equatable {
  const AppThemeColorState();

  @override
  List<Object> get props => [];
}

final class AppThemeColorInitial extends AppThemeColorState {}

class AppThemeColorChanged extends AppThemeColorState{
  final bool lightMode;
  final DateTime date;
  const AppThemeColorChanged(this.date, this.lightMode);

  @override 
  List<Object> get props => [date, lightMode];
}