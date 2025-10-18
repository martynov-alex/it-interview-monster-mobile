// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'create_question_input_grade.dart';
import 'topic_tag_pair.dart';

part 'create_question_input.freezed.dart';
part 'create_question_input.g.dart';

@Freezed()
abstract class CreateQuestionInput with _$CreateQuestionInput {
  const factory CreateQuestionInput({
    /// Код языка
    @JsonKey(name: 'language_code')
    required String languageCode,

    /// Список пар тема-тег
    @JsonKey(name: 'topic_tags')
    required List<TopicTagPair> topicTags,

    /// Уровень сложности
    required CreateQuestionInputGrade grade,

    /// Краткий текст вопроса
    @JsonKey(name: 'short_text')
    required String shortText,

    /// Текст ответа на вопрос
    @JsonKey(name: 'answer_text')
    required String answerText,

    /// Признак вопроса с кодом
    @Default(false)
    bool code,

    /// Полный текст вопроса
    @JsonKey(name: 'full_text')
    String? fullText,
  }) = _CreateQuestionInput;
  
  factory CreateQuestionInput.fromJson(Map<String, Object?> json) => _$CreateQuestionInputFromJson(json);
}
