import 'package:flutter/material.dart';

final ColorScheme appColorScheme = ColorScheme(
  // Brightness
  brightness: Brightness.dark,

  // Primary colors
  primary: const Color(0xFF535D96),
  onPrimary: const Color(0xFFFFFFFF),
  primaryContainer: const Color(0xFF797EAD),
  onPrimaryContainer: const Color(0xFFB1B3D0),

  primaryFixed: const Color(0xFF535D96),
  primaryFixedDim: const Color(0xFF535D96),
  onPrimaryFixed: const Color(0xFF535D96),
  onPrimaryFixedVariant: const Color(0xFF535D96),

  // Secondary colors (using primary variants)
  secondary: const Color(0xFF666DA1),
  onSecondary: const Color(0xFFFFFFFF),
  secondaryContainer: const Color(0xFF8C90B8),
  onSecondaryContainer: const Color(0xFFB1B3D0),

  // Tertiary colors (using tonal surface)
  tertiary: const Color(0xFF3D3D41),
  onTertiary: const Color(0xFFFFFFFF),
  tertiaryContainer: const Color(0xFF555559),
  onTertiaryContainer: const Color(0xFF8A8A8D),

  // Error colors (using danger)
  error: const Color(0xFF9C2121),
  onError: const Color(0xFFFFFFFF),
  errorContainer: const Color(0xFFD94A4A),
  onErrorContainer: const Color(0xFFEB9E9E),

  // Surface colors
  surface: const Color(0xFF020202),
  onSurface: const Color(0xFFFFFFFF),
  surfaceContainerHighest: const Color(0xFF1F1F1F),
  surfaceContainerHigh: const Color(0xFF363636),
  surfaceContainer: const Color(0xFF4F4F4F),
  surfaceContainerLow: const Color(0xFF6A6A6A),
  surfaceContainerLowest: const Color(0xFF868686),

  // Background (deprecated but still used)
  background: const Color(0xFF020202),
  onBackground: const Color(0xFFFFFFFF),

  // Surface variant (using tonal surface)
  surfaceVariant: const Color(0xFF0F0F15),
  onSurfaceVariant: const Color(0xFF8A8A8D),

  // Outline
  outline: const Color(0xFF6F6F72),
  outlineVariant: const Color(0xFF25262A),

  // Other
  shadow: const Color(0xFF000000),
  scrim: const Color(0xFF000000),
  inverseSurface: const Color(0xFFFFFFFF),
  onInverseSurface: const Color(0xFF020202),
  inversePrimary: const Color(0xFFB1B3D0),
);

// Additional semantic colors not in ColorScheme
class AppColors {
  // Success colors
  static const Color successA0 = Color(0xFF22946E);
  static const Color successA10 = Color(0xFF47D5A6);
  static const Color successA20 = Color(0xFF9AE8CE);

  // Warning colors
  static const Color warningA0 = Color(0xFFA87A2A);
  static const Color warningA10 = Color(0xFFD7AC61);
  static const Color warningA20 = Color(0xFFECD7B2);

  // Info colors
  static const Color infoA0 = Color(0xFF21498A);
  static const Color infoA10 = Color(0xFF4077D1);
  static const Color infoA20 = Color(0xFF92B2E5);
}
