# 🚀 Быстрый старт

## Генерация API кода

### Из корня проекта (рекомендуется)

```bash
make gen-api
```

### Или напрямую

```bash
bash scripts/generate_api.bash
```

Это запустит:

1. `swagger_parser` - парсинг OpenAPI и генерация базовых файлов
2. `build_runner` - генерация Freezed и JSON сериализации

## Использование

```dart
import 'package:api/api.dart';
import 'package:dio/dio.dart';

// Создание клиента
final dio = Dio(BaseOptions(
  baseUrl: 'http://localhost:8080/api/question/v1',
));
final api = QuestionApiClient(dio);

// Создание вопроса
const input = CreateQuestionInput(
  languageCode: 'ru',
  topicTags: [TopicTagPair(topic: 'Golang', tag: 'concurrency')],
  grade: CreateQuestionInputGrade.middle,
  shortText: 'Что такое горутина?',
  answerText: 'Легковесный поток',
);

final result = await api.questions.createQuestion(body: input);
print('Created: ${result.id}');

// Получение вопроса
final question = await api.questions.getQuestion(
  id: result.id!,
  languageCode: 'ru',
);

// Список вопросов
final questions = await api.questions.getQuestions(
  languageCode: 'ru',
  topic: 'Golang',
);
```

## Обновление API

1. Измените `schemas/question.yaml`
2. Запустите `make gen-api` (из корня проекта)
3. Готово!

## Конфигурация

Все параметры генерации находятся в `swagger_parser.yaml` с подробными комментариями:

- Путь к OpenAPI файлу
- Выбор сериализатора (freezed/json_serializable/dart_mappable)
- Настройка клиентов и методов
- Фильтрация endpoints
- И многое другое

## Документация

- [swagger_parser.yaml](swagger_parser.yaml) - ⭐ Конфигурация с комментариями
- [README.md](README.md) - Полная документация
- [example/example.dart](example/example.dart) - Примеры использования
- [GENERATION_INFO.md](GENERATION_INFO.md) - Техническая информация
