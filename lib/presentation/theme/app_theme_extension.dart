import 'package:flutter/material.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.main,
    required this.mainLight,
    required this.sub,
    required this.background,
  });
  final Color main;
  final Color mainLight;
  final Color sub;
  final Color background;

  @override
  ThemeExtension<AppThemeExtension> copyWith() => this;

  @override
  ThemeExtension<AppThemeExtension> lerp(
      covariant AppThemeExtension? other, double t) {
    if (other == null) {
      return this;
    }
    return AppThemeExtension(
      main: Color.lerp(main, other.main, t)!,
      mainLight: Color.lerp(mainLight, other.mainLight, t)!,
      sub: Color.lerp(sub, other.sub, t)!,
      background: Color.lerp(background, other.background, t)!,
    );
  }
}