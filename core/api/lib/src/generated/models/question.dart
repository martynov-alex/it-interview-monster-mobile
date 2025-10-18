// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@Freezed()
abstract class Question with _$Question {
  const factory Question({
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
  }) = _Question;
  
  factory Question.fromJson(Map<String, Object?> json) => _$QuestionFromJson(json);
}
