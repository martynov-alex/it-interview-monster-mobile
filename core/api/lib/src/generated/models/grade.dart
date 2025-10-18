// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum Grade {
  @JsonValue('junior')
  junior('junior'),
  @JsonValue('middle')
  middle('middle'),
  @JsonValue('senior')
  senior('senior'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const Grade(this.json);

  factory Grade.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;

  @override
  String toString() => json ?? super.toString();
  /// Returns all defined enum values excluding the $unknown value.
  static List<Grade> get $valuesDefined => values.where((value) => value != $unknown).toList();
}
