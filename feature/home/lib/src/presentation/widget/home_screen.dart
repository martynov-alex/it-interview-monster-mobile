import 'package:api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/bloc/questions_bloc.dart';
import 'package:home/src/bloc/questions_event.dart';
import 'package:home/src/bloc/questions_state.dart';
import 'package:home/src/injection.dart';
import 'package:settings/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final QuestionsBloc _questionsBloc;

  @override
  void initState() {
    super.initState();
    // Initialize the API client and BLoC
    final apiClient = createApiClient(baseUrl: 'http://localhost:8080/api/question/v1');
    final repository = createQuestionsRepository(apiClient: apiClient);
    _questionsBloc = createQuestionsBloc(repository: repository);

    // Load questions on initialization
    _questionsBloc.add(
      const QuestionsEventLoad(
        languageCode: 'ru',
        topic: 'Golang',
        limit: 20,
      ),
    );
  }

  @override
  void dispose() {
    _questionsBloc.close();
    super.dispose();
  }

  Widget _buildColorItem(int index, Color? seedColor) {
    final itemColor = Colors.accents[index];

    return _ColorItem(
      color: itemColor,
      seedColor: seedColor,
      onTap: _onSeedColorChanged,
    );
  }

  void _onSeedColorChanged(Color color) {
    SettingsScope.of(context).settingsBloc.add(
      SettingsEventUpdate(
        onUpdate: (settings) => settings.copyWith(
          theme: settings.theme.copyWith(seedColor: color),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IT Interview Monster')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Seed color',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: SettingsBuilder(
              builder: (context, data) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: Colors.accents.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _buildColorItem(index, data.theme.seedColor);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Questions (Golang)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 16),
          BlocProvider<QuestionsBloc>.value(
            value: _questionsBloc,
            child: BlocBuilder<QuestionsBloc, QuestionsState>(
              builder: (context, state) {
                return switch (state) {
                  QuestionsStateInitial() => const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Press the button to load questions'),
                  ),
                  QuestionsStateLoading() => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  QuestionsStateLoaded(:final questions) =>
                    questions.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('No questions found'),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: questions.length,
                            separatorBuilder: (context, index) => const Divider(),
                            itemBuilder: (context, index) {
                              final question = questions[index];
                              return _QuestionItem(question: question);
                            },
                          ),
                  QuestionsStateError(:final message) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ошибка загрузки вопросов',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.withOpacity(0.3)),
                          ),
                          child: Text(
                            message,
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            _questionsBloc.add(
                              const QuestionsEventLoad(
                                languageCode: 'ru',
                                topic: 'Golang',
                                limit: 20,
                              ),
                            );
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Повторить'),
                        ),
                      ],
                    ),
                  ),
                };
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _questionsBloc.add(
            const QuestionsEventLoad(
              languageCode: 'ru',
              topic: 'Golang',
              limit: 20,
            ),
          );
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({required this.color, required this.seedColor, required this.onTap});

  final ValueChanged<Color> onTap;
  final Color? seedColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => onTap(color),
      child: SizedBox.square(
        dimension: 48,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: seedColor?.toARGB32() == color.toARGB32() ? Colors.black : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(16),
            color: color,
          ),
        ),
      ),
    );
  }
}

class _QuestionItem extends StatelessWidget {
  const _QuestionItem({required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        child: Icon(Icons.question_answer),
      ),
      title: Text(
        question.shortText ?? 'No title',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        'Created: ${question.createdAt?.toString() ?? 'Unknown'}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
