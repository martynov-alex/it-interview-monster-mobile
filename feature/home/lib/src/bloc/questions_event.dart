import 'package:api/api.dart';

/// Base class for questions events
sealed class QuestionsEvent {
  const QuestionsEvent();
}

/// Event to load questions
final class QuestionsEventLoad extends QuestionsEvent {
  const QuestionsEventLoad({
    required this.languageCode,
    required this.topic,
    this.grade,
    this.offset = 0,
    this.limit = 10,
  });

  final String languageCode;
  final String topic;
  final Grade? grade;
  final int offset;
  final int limit;
}
