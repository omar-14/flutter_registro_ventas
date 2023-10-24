import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/config/theme/app_theme.dart';

final themeProvider = StateProvider((ref) => false);

//objeto de tipo AppTheme (custom)
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

//Controller o notifier
class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void toggleDarkmode() {
    state = state.copyWith(isDarkmode: !state.isDarkmode);
  }
}
