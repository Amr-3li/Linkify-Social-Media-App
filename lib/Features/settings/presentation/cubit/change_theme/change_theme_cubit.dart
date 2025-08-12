import 'package:bloc/bloc.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';
import 'package:meta/meta.dart';

part 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  bool _isDarkMode = false;
  ChangeThemeCubit() : super(ChangeThemeInitial()) {
    _loadThemePreference();
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> _loadThemePreference() async {
    emit(ChangeThemeLoading());
    try {
      _isDarkMode = SharedPreferenceSingelton.getBool('isDarkMode');
      emit(ChangeThemeLoaded(isDarkMode: _isDarkMode));
    } catch (e) {
      emit(ChangeThemeError(message: 'Failed to load theme preference'));
    }
  }

  Future<void> changeTheme() async {
    emit(ChangeThemeLoading());
    try {
      _isDarkMode = !_isDarkMode;
      SharedPreferenceSingelton.setBool('isDarkMode', _isDarkMode);
      emit(ChangeThemeLoaded(isDarkMode: _isDarkMode));
    } catch (e) {
      emit(ChangeThemeError(message: 'Failed to change theme'));

      _isDarkMode = !_isDarkMode;
    }
  }
}
