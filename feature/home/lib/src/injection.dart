import 'package:api/api.dart';
import 'package:dio/dio.dart';

import 'package:home/src/bloc/questions_bloc.dart';
import 'package:home/src/data/questions_repository.dart';

/// Creates and configures the API client
RestApiClient createApiClient({required String baseUrl}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  return RestApiClient(dio);
}

/// Creates the questions repository
QuestionsRepository createQuestionsRepository({
  required RestApiClient apiClient,
}) {
  return QuestionsRepository(apiClient: apiClient);
}

/// Creates the questions BLoC
QuestionsBloc createQuestionsBloc({
  required QuestionsRepository repository,
}) {
  return QuestionsBloc(repository: repository);
}
