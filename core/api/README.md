# API Package

Пакет для работы с Question API. Код генерируется автоматически из OpenAPI спецификации используя [`swagger_parser`](https://pub.dev/packages/swagger_parser).

## Структура

```text
core/api/
├── schemas/
│   └── question.yaml       # OpenAPI спецификация
├── lib/
│   ├── api.dart           # Главный файл библиотеки
│   └── src/
│       └── generated/     # Сгенерированный код
├── pubspec.yaml           # Зависимости и конфигурация swagger_parser
├── build.yaml             # Конфигурация build_runner
└── generate.sh            # Скрипт для генерации кода
```

## Генерация кода

### Автоматическая генерация

#### Из корня проекта (рекомендуется)

```bash
make gen-api
```

#### Или напрямую

```bash
bash scripts/generate_api.bash
```

#### Или из папки api

```bash
./generate.sh
```

Генерация выполняет два шага:

1. Генерация кода с помощью `swagger_parser` из OpenAPI спецификации
2. Генерация дополнительного кода с помощью `build_runner` (Freezed, JSON Serializable, Retrofit)

### Ручная генерация

#### Шаг 1: Установка зависимостей

```bash
flutter pub get
```

#### Шаг 2: Генерация с swagger_parser

```bash
dart run swagger_parser
```

#### Шаг 3: Генерация с build_runner

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Конфигурация

Конфигурация `swagger_parser` находится в отдельном файле `swagger_parser.yaml` с подробными комментариями к каждому параметру:

```yaml
swagger_parser:
  # Путь к OpenAPI спецификации
  schema_path: schemas/question.yaml
  
  # Директория для сгенерированных файлов
  output_directory: lib/src/generated
  
  # Имя API
  name: question_api
  
  # Библиотека для сериализации (freezed, json_serializable, dart_mappable)
  json_serializer: freezed
  
  # Генерировать корневой клиент
  root_client: true
  root_client_name: QuestionApiClient
  
  # ... полная конфигурация в swagger_parser.yaml
```

### Основные параметры

- `schema_path` - путь к OpenAPI файлу (или `schema_url` для удаленного файла)
- `output_directory` - директория для сгенерированных файлов
- `json_serializer` - используемый сериализатор:
  - `freezed` - иммутабельные классы с copyWith, ==, toString
  - `json_serializable` - простые data классы с toJson/fromJson  
  - `dart_mappable` - современная альтернатива с лучшей производительностью
- `root_client` - генерировать ли корневой клиент с интерфейсом
- `client_postfix` - постфикс для классов клиентов
- `use_freezed3` - использовать синтаксис Freezed 3.x

**Все параметры с подробными комментариями находятся в файле `swagger_parser.yaml`**

Полную документацию по параметрам см. на [pub.dev](https://pub.dev/packages/swagger_parser).

## Использование

```dart
import 'package:api/api.dart';
import 'package:dio/dio.dart';

void main() async {
  // Создаем Dio клиент
  final dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080/api/question/v1',
  ));

  // Создаем API клиент
  final apiClient = QuestionApiClient(dio);

  // Используем API
  try {
    // Создание вопроса
    final createInput = CreateQuestionInput(
      languageCode: 'ru',
      topicTags: [
        TopicTagPair(topic: 'Golang', tag: 'concurrency'),
      ],
      grade: 'middle',
      shortText: 'Что такое горутина?',
      answerText: 'Легковесный поток',
      code: false,
    );
    
    final createResult = await apiClient.questionsClient.createQuestion(createInput);
    print('Created question with ID: ${createResult.id}');

    // Получение вопроса
    final question = await apiClient.questionsClient.getQuestion(
      id: createResult.id!,
      languageCode: 'ru',
    );
    print('Question: ${question.shortText}');

    // Получение списка вопросов
    final questions = await apiClient.questionsClient.getQuestions(
      languageCode: 'ru',
      topic: 'Golang',
      grade: 'middle',
      limit: 10,
    );
    print('Found ${questions.questions?.length} questions');

  } on DioException catch (e) {
    print('API Error: ${e.response?.statusCode} - ${e.message}');
  }
}
```

## Обновление API

Когда OpenAPI спецификация изменяется:

1. Обновите файл `schemas/question.yaml`
2. Запустите генерацию: `make gen-api` (из корня проекта)
3. Проверьте сгенерированный код
4. Обновите код, использующий API (если изменился интерфейс)

## Зависимости

### Runtime зависимости

- `dio` - HTTP клиент
- `json_annotation` - аннотации для JSON сериализации
- `freezed_annotation` - аннотации для Freezed
- `retrofit` - REST клиент на основе аннотаций

### Dev зависимости

- `swagger_parser` - генератор кода из OpenAPI
- `build_runner` - система сборки для кодогенерации
- `json_serializable` - генератор JSON сериализации
- `freezed` - генератор иммутабельных классов
- `retrofit_generator` - генератор Retrofit клиента

## .gitignore

Добавьте в `.gitignore`:

```text
# Сгенерированные файлы
lib/src/generated/
*.g.dart
*.freezed.dart
```

## Troubleshooting

### Ошибка "No element found"

Если при генерации возникает ошибка парсинга YAML, проверьте:

- Корректность синтаксиса в `schemas/question.yaml`
- Соответствие OpenAPI 3.0+ спецификации

### Конфликты build_runner

Если `build_runner` сообщает о конфликтах:

```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Проблемы с порядком генерации

Убедитесь, что в `build.yaml` настроен правильный порядок выполнения билдеров:

```yaml
global_options:
  freezed:
    runs_before:
      - json_serializable
  json_serializable:
    runs_before:
      - retrofit_generator
```
