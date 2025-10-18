// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'get_question_output_grade.dart';

part 'get_question_output.freezed.dart';
part 'get_question_output.g.dart';

@Freezed()
abstract class GetQuestionOutput with _$GetQuestionOutput {
  const factory GetQuestionOutput({
    /// Уникальный идентификатор вопроса
    String? id,

    /// Дата и время создания
    @JsonKey(name: 'created_at')
    DateTime? createdAt,

    /// Дата и время последнего обновления
    @JsonKey(name: 'updated_at')
    DateTime? updatedAt,

    /// Краткий текст вопроса
    @JsonKey(name: 'short_text')
    String? shortText,

    /// Полный текст вопроса
    @JsonKey(name: 'full_text')
    String? fullText,

    /// Текст ответа на вопрос
    @JsonKey(name: 'answer_text')
    String? answerText,

    /// Признак вопроса с кодом
    bool? code,

    /// Список тем
    List<String>? topics,

    /// Список тегов
    List<String>? tags,

    /// Уровень сложности
    GetQuestionOutputGrade? grade,
  }) = _GetQuestionOutput;
  
  factory GetQuestionOutput.fromJson(Map<String, Object?> json) => _$GetQuestionOutputFromJson(json);
}
