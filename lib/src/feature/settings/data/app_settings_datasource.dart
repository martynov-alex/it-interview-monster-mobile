import 'dart:ui';

import 'package:it_interview_monster/src/core/common/color_codec.dart';
import 'package:it_interview_monster/src/core/common/persisted_entry.dart';
import 'package:it_interview_monster/src/feature/settings/data/theme_mode_codec.dart';
import 'package:it_interview_monster/src/feature/settings/model/app_settings.dart';
import 'package:it_interview_monster/src/feature/settings/model/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [AppSettingsDatasource] sets and gets app settings.
abstract interface class AppSettingsDatasource {
  /// Set app settings
  Future<void> setAppSettings(AppSettings appSettings);

  /// Load [AppSettings] from the source of truth.
  Future<AppSettings?> getAppSettings();
}

final class AppSettingsDatasourceImpl implements AppSettingsDatasource {
  AppSettingsDatasourceImpl({required this.sharedPreferences});

  /// The instance of [SharedPreferences] used to read and write values.
  final SharedPreferencesAsync sharedPreferences;

  late final _appSettings = AppSettingsPersistedEntry(
    sharedPreferences: sharedPreferences,
    key: 'settings',
  );

  @override
  Future<AppSettings?> getAppSettings() => _appSettings.read();

  @override
  Future<void> setAppSettings(AppSettings appSettings) =>
      _appSettings.set(appSettings);
}

/// Persisted entry for [AppSettings]
class AppSettingsPersistedEntry extends SharedPreferencesEntry<AppSettings> {
  /// Create [AppSettingsPersistedEntry]
  AppSettingsPersistedEntry({
    required super.sharedPreferences,
    required super.key,
  });

  late final _themeMode = StringPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.themeMode',
  );

  late final _themeSeedColor = IntPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.seedColor',
  );

  late final _localeLanguageCode = StringPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.locale.languageCode',
  );

  late final _localeCountryCode = StringPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.locale.countryCode',
  );

  late final _textScale = DoublePreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.textScale',
  );

  static const _colorCodec = ColorCodec();

  @override
  Future<AppSettings?> read() async {
    final themeModeFuture = _themeMode.read();
    final themeSeedColorFuture = _themeSeedColor.read();
    final localeLanguageCodeFuture = _localeLanguageCode.read();
    final countryCodeFuture = _localeCountryCode.read();

    final textScale = await _textScale.read();
    final themeMode = await themeModeFuture;
    final themeSeedColor = await themeSeedColorFuture;
    final languageCode = await localeLanguageCodeFuture;
    final countryCode = await countryCodeFuture;

    if (themeMode == null &&
        themeSeedColor == null &&
        languageCode == null &&
        textScale == null &&
        countryCode == null) {
      return null;
    }

    AppTheme? appTheme;

    if (themeMode != null && themeSeedColor != null) {
      appTheme = AppTheme(
        themeMode: const ThemeModeCodec().decode(themeMode),
        seed: _colorCodec.decode(themeSeedColor),
      );
    }

    Locale? appLocale;

    if (languageCode != null) {
      appLocale = Locale(languageCode, countryCode);
    }

    return AppSettings(
      appTheme: appTheme,
      locale: appLocale,
      textScale: textScale,
    );
  }

  @override
  Future<void> remove() async {
    await (
      _themeMode.remove(),
      _themeSeedColor.remove(),
      _localeLanguageCode.remove(),
      _localeCountryCode.remove(),
      _textScale.remove(),
    ).wait;
  }

  @override
  Future<void> set(AppSettings value) async {
    if (value.appTheme != null) {
      await (
        _themeMode.set(
          const ThemeModeCodec().encode(value.appTheme!.themeMode),
        ),
        _themeSeedColor.set(_colorCodec.encode(value.appTheme!.seed)),
      ).wait;
    }

    if (value.locale != null) {
      await (
        _localeLanguageCode.set(value.locale!.languageCode),
        _localeCountryCode.set(value.locale!.countryCode ?? ''),
      ).wait;
    }

    if (value.textScale != null) {
      await _textScale.set(value.textScale!);
    }
  }
}
