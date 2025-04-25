import 'package:flutter/material.dart';
import 'package:it_interview_monster/src/feature/initialization/widget/dependencies_scope.dart';

/// HomeScreen is a simple screen that displays a grid of items.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final _logger = DependenciesScope.of(context).logger;

  @override
  void initState() {
    super.initState();
    _logger.info('Hello world!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hello world!',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            Builder(builder: (context) => const Text('Hello')),
          ],
        ),
      ),
    );
  }
}
