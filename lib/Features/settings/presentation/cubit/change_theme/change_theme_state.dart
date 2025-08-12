part of 'change_theme_cubit.dart';

@immutable
sealed class ChangeThemeState {}

final class ChangeThemeInitial extends ChangeThemeState {}

final class ChangeThemeLoaded extends ChangeThemeState {
  final bool isDarkMode;
  ChangeThemeLoaded({required this.isDarkMode});
}

final class ChangeThemeError extends ChangeThemeState {
  final String message;
  ChangeThemeError({required this.message});
}

final class ChangeThemeLoading extends ChangeThemeState {}
