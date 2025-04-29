import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// An immutable class that holds properties needed to build a [ThemeData] for the app.
@immutable
final class AppTheme with Diagnosticable {
  const AppTheme({required this.themeMode, required this.seed});

  /// The type of theme to use.
  final ThemeMode themeMode;

  /// The seed color to generate the [ColorScheme] from.
  final Color seed;

  /// The default theme to use.
  static const defaultTheme = AppTheme(
    themeMode: ThemeMode.system,
    seed: Color(0xFF6200EE),
  );

  /// Builds a [ThemeData] based on the [themeMode] and [seed].
  ///
  /// This can also be used to add additional properties to the [ThemeData],
  /// such as extensions or custom properties.
  ThemeData buildThemeData(Brightness brightness) {
    final baseTheme = switch (brightness) {
      Brightness.light => ThemeData.light(useMaterial3: true),
      Brightness.dark => ThemeData.dark(useMaterial3: true),
    };

    return baseTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: brightness,
      ),
      textTheme: GoogleFonts.jostTextTheme(baseTheme.textTheme),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('seed', seed));
    properties.add(EnumProperty<ThemeMode>('type', themeMode));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme && seed == other.seed && themeMode == other.themeMode;

  @override
  int get hashCode => Object.hash(seed, themeMode);
}
