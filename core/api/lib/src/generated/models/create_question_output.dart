// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_question_output.freezed.dart';
part 'create_question_output.g.dart';

@Freezed()
abstract class CreateQuestionOutput with _$CreateQuestionOutput {
  const factory CreateQuestionOutput({
    /// Уникальный идентификатор созданного вопроса
    String? id,
  }) = _CreateQuestionOutput;
  
  factory CreateQuestionOutput.fromJson(Map<String, Object?> json) => _$CreateQuestionOutputFromJson(json);
}
