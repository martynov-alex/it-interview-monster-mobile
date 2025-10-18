// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum Sort {
  @JsonValue('created_at')
  createdAt('created_at'),
  @JsonValue('updated_at')
  updatedAt('updated_at'),
  @JsonValue('short_text')
  shortText('short_text'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const Sort(this.json);

  factory Sort.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;

  @override
  String toString() => json ?? super.toString();
  /// Returns all defined enum values excluding the $unknown value.
  static List<Sort> get $valuesDefined => values.where((value) => value != $unknown).toList();
}
