import 'package:api/api.dart';

/// Repository for fetching questions from the API
class QuestionsRepository {
  QuestionsRepository({
    required RestApiClient apiClient,
  }) : _apiClient = apiClient;

  final RestApiClient _apiClient;

  /// Fetches a list of questions based on the provided parameters
  Future<List<Question>> getQuestions({
    required String languageCode,
    required String topic,
    Grade? grade,
    Sort? sort,
    Order? order,
    int? offset,
    int? limit,
  }) async {
    final response = await _apiClient.questions.getQuestions(
      languageCode: languageCode,
      topic: topic,
      grade: grade,
      sort: sort ?? Sort.createdAt,
      order: order ?? Order.desc,
      offset: offset ?? 0,
      limit: limit ?? 10,
    );

    return response.questions ?? [];
  }
}
