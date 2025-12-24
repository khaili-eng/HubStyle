
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(isDarkMode: false));
  static const String _themeKey = 'isDarkMode';
  Future<void> loadTheme() async{
    final pre = await SharedPreferences.getInstance();
    final isDarkMode = pre.getBool(_themeKey)?? false;
    emit(state.copyWith(isDarkMode: isDarkMode));
  }
  Future<void>toggleTheme(bool isDark) async{
    final pre = await SharedPreferences.getInstance();
    await pre.setBool(_themeKey,isDark);
    emit( state.copyWith(isDarkMode: isDark));
  }
}
