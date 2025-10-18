// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'question.dart';

part 'get_questions_output.freezed.dart';
part 'get_questions_output.g.dart';

@Freezed()
abstract class GetQuestionsOutput with _$GetQuestionsOutput {
  const factory GetQuestionsOutput({
    /// Список вопросов
    List<Question>? questions,
  }) = _GetQuestionsOutput;
  
  factory GetQuestionsOutput.fromJson(Map<String, Object?> json) => _$GetQuestionsOutputFromJson(json);
}
