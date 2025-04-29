import 'package:it_interview_monster/src/core/common/persisted_entry.dart';
import 'package:it_interview_monster/src/feature/auth/domain/entity/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class TokenStorage {
  Future<Token?> load();

  Future<void> save(Token tokenPair);

  Future<void> clear();
}

final class TokenStorageImpl implements TokenStorage {
  TokenStorageImpl({required SharedPreferencesAsync sharedPreferences})
    : _accessToken = StringPreferencesEntry(
        sharedPreferences: sharedPreferences,
        key: 'authorization.access_token',
      ),
      _refreshToken = StringPreferencesEntry(
        sharedPreferences: sharedPreferences,
        key: 'authorization.refresh_token',
      );

  late final SharedPreferencesEntry<String> _accessToken;
  late final SharedPreferencesEntry<String> _refreshToken;

  @override
  Future<Token?> load() async {
    final accessToken = await _accessToken.read();
    final refreshToken = await _refreshToken.read();

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return Token(accessToken, refreshToken);
  }

  @override
  Future<void> save(Token tokenPair) async {
    await (
      _accessToken.set(tokenPair.accessToken),
      _refreshToken.set(tokenPair.refreshToken),
    ).wait;
  }

  @override
  Future<void> clear() async {
    await (_accessToken.remove(), _refreshToken.remove()).wait;
  }
}
