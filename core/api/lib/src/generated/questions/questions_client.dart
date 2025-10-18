// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/create_question_input.dart';
import '../models/create_question_output.dart';
import '../models/get_question_output.dart';
import '../models/get_questions_output.dart';
import '../models/grade.dart';
import '../models/order.dart';
import '../models/sort.dart';

part 'questions_client.g.dart';

@RestApi()
abstract class QuestionsClient {
  factory QuestionsClient(Dio dio, {String? baseUrl}) = _QuestionsClient;

  /// Создать новый вопрос.
  ///
  /// Создает новый вопрос с указанными параметрами.
  @POST('/question')
  Future<CreateQuestionOutput> createQuestion({
    @Body() required CreateQuestionInput body,
  });

  /// Получить вопрос по ID.
  ///
  /// Возвращает полную информацию о вопросе по его идентификатору.
  ///
  /// [id] - Уникальный идентификатор вопроса.
  ///
  /// [languageCode] - Код языка (ru, en).
  @GET('/question')
  Future<GetQuestionOutput> getQuestion({
    @Query('id') required String id,
    @Query('language_code') required String languageCode,
  });

  /// Получить список вопросов.
  ///
  /// Возвращает список вопросов с возможностью фильтрации и пагинации.
  ///
  /// [languageCode] - Код языка (ru, en).
  ///
  /// [topic] - Название темы для фильтрации.
  ///
  /// [tags] - Список тегов для фильтрации (разделенные запятой).
  ///
  /// [grade] - Уровень сложности.
  ///
  /// [code] - Фильтр вопросов с кодом.
  ///
  /// [sort] - Поле для сортировки.
  ///
  /// [order] - Порядок сортировки.
  ///
  /// [offset] - Смещение для пагинации.
  ///
  /// [limit] - Количество элементов на странице.
  @GET('/questions')
  Future<GetQuestionsOutput> getQuestions({
    @Query('language_code') required String languageCode,
    @Query('topic') required String topic,
    @Query('sort') Sort? sort = Sort.createdAt,
    @Query('order') Order? order = Order.asc,
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 10,
    @Query('tags') String? tags,
    @Query('grade') Grade? grade,
    @Query('code') bool? code,
  });

  /// Удалить вопрос.
  ///
  /// Удаляет вопрос по его идентификатору.
  ///
  /// [id] - Уникальный идентификатор вопроса.
  @DELETE('/question/{id}')
  Future<void> deleteQuestion({
    @Path('id') required String id,
  });
}
