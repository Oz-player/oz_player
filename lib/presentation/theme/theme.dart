import 'package:flutter/material.dart';
import 'package:oz_player/presentation/theme/app_theme_extension.dart';

class LightTheme extends AppThemeExtension {
  const LightTheme({
    super.main = Colors.black,
    super.mainLight = Colors.grey,
    super.sub = Colors.black,
    super.background = Colors.white,
  });
}

class DarkTheme extends AppThemeExtension {
  const DarkTheme({
    super.main = const Color(0xFF0000FF),
    super.mainLight = const Color(0xAA0000FF),
    super.sub = const Color(0xFFFF00FF),
    super.background = Colors.black,
  });
}

final lightTheme = _theme(Brightness.light, const LightTheme());
final darkTheme = _theme(Brightness.dark, const DarkTheme());

ThemeData _theme(Brightness brightness, AppThemeExtension ext) => ThemeData(
    brightness: brightness,
    useMaterial3: true,
    scaffoldBackgroundColor: ext.background,
    colorScheme: ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: ext.main,
      primary: Colors.black,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: ext.main, linearTrackColor: ext.mainLight),
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
    extensions: [ext],
    appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xff0D0019),
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shadowColor: WidgetStatePropertyAll(
          Colors.transparent,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    fontFamily: 'Pretendard');

extension BuildContextThemeExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  AppThemeExtension get appColor => theme.extension<AppThemeExtension>()!;
}
