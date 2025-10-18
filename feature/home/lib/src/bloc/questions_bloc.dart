import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/bloc/questions_event.dart';
import 'package:home/src/bloc/questions_state.dart';
import 'package:home/src/data/questions_repository.dart';

/// BLoC for managing questions
class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc({
    required QuestionsRepository repository,
  }) : _repository = repository,
       super(const QuestionsStateInitial()) {
    on<QuestionsEventLoad>(_onLoad);
  }

  final QuestionsRepository _repository;

  Future<void> _onLoad(
    QuestionsEventLoad event,
    Emitter<QuestionsState> emit,
  ) async {
    emit(const QuestionsStateLoading());

    try {
      final questions = await _repository.getQuestions(
        languageCode: event.languageCode,
        topic: event.topic,
        grade: event.grade,
        offset: event.offset,
        limit: event.limit,
      );

      emit(QuestionsStateLoaded(questions: questions));
    } catch (e) {
      var errorMessage = e.toString();

      // Улучшенная обработка ошибок подключения
      if (errorMessage.contains('connection error') || errorMessage.contains('XMLHttpRequest')) {
        errorMessage =
            'Не удалось подключиться к серверу.\n'
            'Убедитесь, что backend запущен на http://localhost:8080';
      } else if (errorMessage.contains('SocketException')) {
        errorMessage =
            'Сервер недоступен.\n'
            'Проверьте, что backend запущен.';
      }

      emit(QuestionsStateError(message: errorMessage));
    }
  }
}
