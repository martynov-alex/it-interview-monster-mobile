import 'package:api/api.dart';

/// Base class for questions state
sealed class QuestionsState {
  const QuestionsState();
}

/// Initial state
final class QuestionsStateInitial extends QuestionsState {
  const QuestionsStateInitial();
}

/// Loading state
final class QuestionsStateLoading extends QuestionsState {
  const QuestionsStateLoading();
}

/// Loaded state with questions
final class QuestionsStateLoaded extends QuestionsState {
  const QuestionsStateLoaded({
    required this.questions,
  });

  final List<Question> questions;
}

/// Error state
final class QuestionsStateError extends QuestionsState {
  const QuestionsStateError({
    required this.message,
  });

  final String message;
}
