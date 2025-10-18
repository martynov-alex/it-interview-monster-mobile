// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';

import 'questions/questions_client.dart';

/// IT Interview Monster API `v1.0.0`.
///
/// API для управления вопросами технических интервью.
class RestApiClient {
  RestApiClient(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  static String get version => '1.0.0';

  QuestionsClient? _questions;

  QuestionsClient get questions => _questions ??= QuestionsClient(_dio, baseUrl: _baseUrl);
}
