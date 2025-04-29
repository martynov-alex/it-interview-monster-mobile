import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:it_interview_monster/src/core/navigation/redirect_builder.dart';
import 'package:it_interview_monster/src/feature/auth/domain/entity/authentication_status.dart';
import 'package:it_interview_monster/src/feature/initialization/widget/dependencies_scope.dart';


/// Гард, который направляет пользователя на главный экран, если он авторизован.
final class RedirectIfAuthenticatedGuard extends RedirectGuard {
  @override
  Pattern get matchPattern => RegExp(r'^/login$');

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    final auth = DependenciesScope.of(context).authBloc.state;

    if (auth.status == AuthenticationStatus.authenticated) {
      return '/top-secret-data';
    }

    return null;
  }
}

/// Гард, который направляет пользователя на экран входа, если он не авторизован.
final class RedirectIfUnauthenticatedGuard extends RedirectGuard {
  @override
  Pattern get matchPattern => RegExp(r'^/login$');

  @override
  bool get invertMatch => true;

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    final auth = DependenciesScope.of(context).authBloc.state;

    if (auth.status == AuthenticationStatus.unauthenticated) {
      return '/login';
    }

    return null;
  }
}
