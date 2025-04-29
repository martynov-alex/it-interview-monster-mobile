// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$loginRouteData, $homeRouteData];

RouteBase get $loginRouteData => GoRouteData.$route(
  path: '/login',

  factory: $LoginRouteDataExtension._fromState,
);

extension $LoginRouteDataExtension on LoginRouteData {
  static LoginRouteData _fromState(GoRouterState state) =>
      const LoginRouteData();

  String get location => GoRouteData.$location('/login');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeRouteData => ShellRouteData.$route(
  navigatorKey: HomeRouteData.$navigatorKey,
  factory: $HomeRouteDataExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/question-list',

      factory: $QuestionListRouteDataExtension._fromState,
    ),
    GoRouteData.$route(
      path: '/settings',

      factory: $SettingsRouteDataExtension._fromState,
    ),
  ],
);

extension $HomeRouteDataExtension on HomeRouteData {
  static HomeRouteData _fromState(GoRouterState state) => const HomeRouteData();
}

extension $QuestionListRouteDataExtension on QuestionListRouteData {
  static QuestionListRouteData _fromState(GoRouterState state) =>
      const QuestionListRouteData();

  String get location => GoRouteData.$location('/question-list');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsRouteDataExtension on SettingsRouteData {
  static SettingsRouteData _fromState(GoRouterState state) =>
      const SettingsRouteData();

  String get location => GoRouteData.$location('/settings');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
