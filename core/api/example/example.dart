// ignore_for_file: avoid_print

import 'package:api/api.dart';
import 'package:dio/dio.dart';

void main() async {
  // Создаем Dio клиент с базовой конфигурацией
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080/api/question/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Создаем API клиент
  final apiClient = RestApiClient(dio);

  try {
    // Пример 1: Создание вопроса
    print('📝 Создание нового вопроса...');
    const createInput = CreateQuestionInput(
      languageCode: 'ru',
      topicTags: [
        TopicTagPair(
          topic: 'Golang',
          tag: 'concurrency',
        ),
      ],
      grade: CreateQuestionInputGrade.middle,
      shortText: 'Что такое горутина?',
      fullText: 'Подробно объясните концепцию горутин в Go',
      answerText: 'Горутина - это легковесный поток выполнения, управляемый средой выполнения Go',
    );

    final createResult = await apiClient.questions.createQuestion(body: createInput);
    print('✅ Вопрос создан с ID: ${createResult.id}');

    // Пример 2: Получение вопроса по ID
    if (createResult.id != null) {
      print('\n📖 Получение вопроса по ID...');
      final question = await apiClient.questions.getQuestion(
        id: createResult.id!,
        languageCode: 'ru',
      );
      print('✅ Получен вопрос: "${question.shortText}"');
      print('   Тема: ${question.topics?.join(", ")}');
      print('   Теги: ${question.tags?.join(", ")}');
      print('   Уровень: ${question.grade}');
      print('   Ответ: ${question.answerText}');
    }

    // Пример 3: Получение списка вопросов
    print('\n📚 Получение списка вопросов...');
    final questionsResponse = await apiClient.questions.getQuestions(
      languageCode: 'ru',
      topic: 'Golang',
      grade: Grade.middle,
      order: Order.desc,
    );

    print('✅ Найдено вопросов: ${questionsResponse.questions?.length ?? 0}');
    if (questionsResponse.questions != null) {
      for (final q in questionsResponse.questions!) {
        print('   - ${q.shortText} (${q.id})');
      }
    }

    // Пример 4: Удаление вопроса
    if (createResult.id != null) {
      print('\n🗑️  Удаление вопроса...');
      await apiClient.questions.deleteQuestion(id: createResult.id!);
      print('✅ Вопрос удален');
    }
  } on DioException catch (e) {
    print('❌ Ошибка API: ${e.response?.statusCode} - ${e.message}');
    if (e.response?.data != null) {
      print('   Данные ошибки: ${e.response?.data}');
    }
  } catch (e) {
    print('❌ Неожиданная ошибка: $e');
  }
}
