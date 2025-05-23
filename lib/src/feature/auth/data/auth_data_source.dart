import 'package:it_interview_monster/src/feature/auth/domain/entity/token.dart';

abstract interface class AuthDataSource {
  Future<Token> signInWithOAuth();

  Future<void> logout();
}

final class FakeAuthDataSource implements AuthDataSource {
  const FakeAuthDataSource();

  @override
  Future<Token> signInWithOAuth() async {
    // Kinda fake auth
    await Future.delayed(const Duration(seconds: 2));

    final String accessToken = 'accessToken';
    final String refreshToken = 'refreshToken';

    return Token(accessToken, refreshToken);
  }

  @override
  Future<void> logout() async {
    // Kinda fake sign out
    await Future.delayed(const Duration(seconds: 2));
  }
}
