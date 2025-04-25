import 'package:shared_preferences/shared_preferences.dart';

/// [PersistedEntry] describes a single persisted entry.
abstract class PersistedEntry<T extends Object> {
  const PersistedEntry();

  /// Read the value from the cache.
  Future<T?> read();

  /// Set the value in the cache.
  Future<void> set(T value);

  /// Remove the value from the cache.
  Future<void> remove();

  /// Set the value in the cache if the value is not null, otherwise remove the value from the cache.
  Future<void> setIfNullRemove(T? value) =>
      value == null ? remove() : set(value);
}

/// [SharedPreferencesEntry] describes a single persisted entry in [SharedPreferences].
abstract class SharedPreferencesEntry<T extends Object>
    extends PersistedEntry<T> {
  const SharedPreferencesEntry({
    required this.sharedPreferences,
    required this.key,
  });

  /// The instance of [SharedPreferences] used to read and write values.
  final SharedPreferencesAsync sharedPreferences;

  /// The key used to store the value in the cache.
  final String key;
}

/// A [int] implementation of [SharedPreferencesEntry].
class IntPreferencesEntry extends SharedPreferencesEntry<int> {
  const IntPreferencesEntry({
    required super.sharedPreferences,
    required super.key,
  });

  @override
  Future<int?> read() => sharedPreferences.getInt(key);

  @override
  Future<void> set(int value) async {
    await sharedPreferences.setInt(key, value);
  }

  @override
  Future<void> remove() async {
    await sharedPreferences.remove(key);
  }
}

/// A [String] implementation of [SharedPreferencesEntry].
class StringPreferencesEntry extends SharedPreferencesEntry<String> {
  const StringPreferencesEntry({
    required super.sharedPreferences,
    required super.key,
  });

  @override
  Future<String?> read() => sharedPreferences.getString(key);

  @override
  Future<void> set(String value) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  Future<void> remove() async {
    await sharedPreferences.remove(key);
  }
}

/// A [bool] implementation of [SharedPreferencesEntry].
class BoolPreferencesEntry extends SharedPreferencesEntry<bool> {
  const BoolPreferencesEntry({
    required super.sharedPreferences,
    required super.key,
  });

  @override
  Future<bool?> read() => sharedPreferences.getBool(key);

  @override
  Future<void> set(bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  @override
  Future<void> remove() async {
    await sharedPreferences.remove(key);
  }
}

/// A [double] implementation of [SharedPreferencesEntry].
class DoublePreferencesEntry extends SharedPreferencesEntry<double> {
  const DoublePreferencesEntry({
    required super.sharedPreferences,
    required super.key,
  });

  @override
  Future<double?> read() => sharedPreferences.getDouble(key);

  @override
  Future<void> set(double value) async {
    await sharedPreferences.setDouble(key, value);
  }

  @override
  Future<void> remove() async {
    await sharedPreferences.remove(key);
  }
}

/// A [List<String>] implementation of [SharedPreferencesEntry].
class StringListPreferencesEntry extends SharedPreferencesEntry<List<String>> {
  const StringListPreferencesEntry({
    required super.sharedPreferences,
    required super.key,
  });

  @override
  Future<List<String>?> read() => sharedPreferences.getStringList(key);

  @override
  Future<void> set(List<String> value) async {
    await sharedPreferences.setStringList(key, value);
  }

  @override
  Future<void> remove() async {
    await sharedPreferences.remove(key);
  }
}
