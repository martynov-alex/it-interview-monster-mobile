import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:it_interview_monster/src/feature/auth/widget/login_screen.dart';
import 'package:it_interview_monster/src/feature/home/widget/home_screen.dart';
import 'package:it_interview_monster/src/feature/question_list/widget/question_list_screen.dart';
import 'package:it_interview_monster/src/feature/settings/widget/settings_screen.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

@TypedGoRoute<LoginRouteData>(path: '/login')
class LoginRouteData extends GoRouteData {
  const LoginRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginScreen();
}

@TypedShellRoute<HomeRouteData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<QuestionListRouteData>(path: '/question-list'),
    TypedGoRoute<SettingsRouteData>(path: '/settings'),
  ],
)
class HomeRouteData extends ShellRouteData {
  const HomeRouteData();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return HomeScreen(navigator: navigator);
  }
}

class QuestionListRouteData extends GoRouteData {
  const QuestionListRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const QuestionListScreen();
}

class SettingsRouteData extends GoRouteData {
  const SettingsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}
