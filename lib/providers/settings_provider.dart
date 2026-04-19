import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsState {
  final ThemeMode themeMode;
  final double arabicFontSize;

  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.arabicFontSize = 28.0,
  });

  SettingsState copyWith({ThemeMode? themeMode, double? arabicFontSize}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      arabicFontSize: arabicFontSize ?? this.arabicFontSize,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState());

  void toggleTheme(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void updateFontSize(double size) {
    state = state.copyWith(arabicFontSize: size);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) {
    return SettingsNotifier();
  },
);
