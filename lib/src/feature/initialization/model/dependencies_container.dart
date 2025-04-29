import 'package:go_router/go_router.dart';
import 'package:it_interview_monster/src/core/common/error_reporter/error_reporter.dart';
import 'package:it_interview_monster/src/core/constant/application_config.dart';
import 'package:it_interview_monster/src/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:it_interview_monster/src/feature/settings/bloc/app_settings_bloc.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Container used to reuse dependencies across the application.
class DependenciesContainer {
  const DependenciesContainer({
    required this.logger,
    required this.config,
    required this.router,
    required this.appSettingsBloc,
    required this.authBloc,
    required this.errorReporter,
    required this.packageInfo,
  });

  /// [Logger] instance, used to log messages.
  final Logger logger;

  /// [ApplicationConfig] instance, contains configuration of the application.
  final ApplicationConfig config;

  /// [GoRouter] instance, used to manage routing.
  final GoRouter router;

  /// [AppSettingsBloc] instance, used to manage theme and locale.
  final AppSettingsBloc appSettingsBloc;

  /// [AuthBloc] instance, used to manage authentication.
  final AuthBloc authBloc;

  /// [ErrorReporter] instance, used to report errors.
  final ErrorReporter errorReporter;

  /// [PackageInfo] instance, contains information about the application.
  final PackageInfo packageInfo;
}

/// A special version of [DependenciesContainer] that is used in tests.
///
/// In order to use [DependenciesContainer] in tests, it is needed to
/// extend this class and provide the dependencies that are needed for the test.
base class TestDependenciesContainer implements DependenciesContainer {
  const TestDependenciesContainer();

  @override
  Object noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'The test tries to access ${invocation.memberName} dependency, but '
      'it was not provided. Please provide the dependency in the test. '
      'You can do it by extending this class and providing the dependency.',
    );
  }
}
