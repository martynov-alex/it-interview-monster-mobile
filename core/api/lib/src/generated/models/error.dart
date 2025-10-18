// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error.freezed.dart';
part 'error.g.dart';

@Freezed()
abstract class Error with _$Error {
  const factory Error({
    /// Описание ошибки
    String? error,
  }) = _Error;
  
  factory Error.fromJson(Map<String, Object?> json) => _$ErrorFromJson(json);
}
