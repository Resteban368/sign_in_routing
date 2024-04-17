import 'package:flutter/material.dart';

class AppTheme {
  factory AppTheme() => _instance;

  AppTheme._();

  static final AppTheme _instance = AppTheme._();

  ThemeData? _dark;
  ThemeData? _light;

  ThemeData get dark => _dark ??= _build(isLight: false);

  ThemeData get light => _light ??= _build(isLight: true);

  ThemeData _build({required bool isLight}) => ThemeData(
        brightness: isLight ? Brightness.light : Brightness.dark,
        colorSchemeSeed: const Color(0xFFCC0000),
      );
}
