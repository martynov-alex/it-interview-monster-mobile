import 'package:clock/clock.dart';
import 'package:it_interview_monster/src/core/common/error_reporter/error_reporter.dart';
import 'package:it_interview_monster/src/core/common/error_reporter/sentry_error_reporter.dart';
import 'package:it_interview_monster/src/core/constant/application_config.dart';
import 'package:it_interview_monster/src/feature/initialization/model/dependencies_container.dart';
import 'package:it_interview_monster/src/feature/settings/bloc/app_settings_bloc.dart';
import 'package:it_interview_monster/src/feature/settings/data/app_settings_datasource.dart';
import 'package:it_interview_monster/src/feature/settings/data/app_settings_repository.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A place where top-level dependencies are initialized.
///
/// Composition of dependencies is a process of creating and configuring
/// instances of classes that are required for the application to work.
final class CompositionRoot {
  const CompositionRoot({required this.config, required this.logger, required this.errorReporter});

  /// Application configuration.
  final ApplicationConfig config;

  /// Logger used to log information during composition process.
  final Logger logger;

  /// Error tracking manager used to track errors in the application.
  final ErrorReporter errorReporter;

  /// Composes dependencies and returns the result of composition.
  Future<CompositionResult> compose() async {
    final stopwatch = clock.stopwatch()..start();

    logger.info('Initializing dependencies...');

    // Create the dependencies container using functions.
    final dependencies = await createDependenciesContainer(config, logger, errorReporter);

    stopwatch.stop();
    logger.info('Dependencies initialized successfully in ${stopwatch.elapsedMilliseconds} ms.');

    return CompositionResult(
      dependencies: dependencies,
      millisecondsSpent: stopwatch.elapsedMilliseconds,
    );
  }
}

/// Result of composition.
final class CompositionResult {
  const CompositionResult({required this.dependencies, required this.millisecondsSpent});

  /// The dependencies container.
  final DependenciesContainer dependencies;

  /// The number of milliseconds spent composing dependencies.
  final int millisecondsSpent;

  @override
  String toString() =>
      'CompositionResult('
      'dependencies: $dependencies, '
      'millisecondsSpent: $millisecondsSpent'
      ')';
}

/// Creates the full dependencies container.
Future<DependenciesContainer> createDependenciesContainer(
  ApplicationConfig config,
  Logger logger,
  ErrorReporter errorReporter,
) async {
  // Create or obtain the shared preferences instance.
  final sharedPreferences = SharedPreferencesAsync();

  // Get package info.
  final packageInfo = await PackageInfo.fromPlatform();

  // Create the AppSettingsBloc using shared preferences.
  final appSettingsBloc = await createAppSettingsBloc(sharedPreferences);

  return DependenciesContainer(
    logger: logger,
    config: config,
    errorReporter: errorReporter,
    packageInfo: packageInfo,
    appSettingsBloc: appSettingsBloc,
  );
}

/// Creates an instance of [Logger] and attaches any provided observers.
Logger createAppLogger({List<LogObserver> observers = const []}) {
  final logger = Logger();

  for (final observer in observers) {
    logger.addObserver(observer);
  }

  return logger;
}

/// Creates an instance of [ErrorReporter] (using Sentry) and initializes it if needed.
Future<ErrorReporter> createErrorReporter(ApplicationConfig config) async {
  final errorReporter = SentryErrorReporter(
    sentryDsn: config.sentryDsn,
    environment: config.environment.value,
  );

  if (config.sentryDsn.isNotEmpty) {
    await errorReporter.initialize();
  }

  return errorReporter;
}

/// Creates an instance of [AppSettingsBloc].
///
/// The [AppSettingsBloc] is initialized at startup to load the app settings from local storage.
Future<AppSettingsBloc> createAppSettingsBloc(SharedPreferencesAsync sharedPreferences) async {
  final appSettingsRepository = AppSettingsRepositoryImpl(
    datasource: AppSettingsDatasourceImpl(sharedPreferences: sharedPreferences),
  );

  final appSettings = await appSettingsRepository.getAppSettings();
  final initialState = AppSettingsState.idle(appSettings: appSettings);

  return AppSettingsBloc(appSettingsRepository: appSettingsRepository, initialState: initialState);
}
