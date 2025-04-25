import 'package:it_interview_monster/src/feature/settings/data/app_settings_datasource.dart';
import 'package:it_interview_monster/src/feature/settings/model/app_settings.dart';

/// [AppSettingsRepository] sets and gets app settings.
abstract interface class AppSettingsRepository {
  /// Set app settings
  Future<void> setAppSettings(AppSettings appSettings);

  /// Load [AppSettings] from the source of truth.
  Future<AppSettings?> getAppSettings();
}

final class AppSettingsRepositoryImpl implements AppSettingsRepository {
  const AppSettingsRepositoryImpl({required this.datasource});

  /// The instance of [AppSettingsDatasource] used to read and write values.
  final AppSettingsDatasource datasource;

  @override
  Future<AppSettings?> getAppSettings() => datasource.getAppSettings();

  @override
  Future<void> setAppSettings(AppSettings appSettings) =>
      datasource.setAppSettings(appSettings);
}
