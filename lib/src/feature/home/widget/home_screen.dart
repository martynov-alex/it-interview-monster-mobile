import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:it_interview_monster/src/core/navigation/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigator});

  final Widget navigator;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/settings')) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = getCurrentIndex(context);

    return Scaffold(
      body: Center(child: widget.navigator),
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.dataset_outlined),
            label: 'Вопросы',
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Настройки'),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          switch (index) {
            case 0:
              const QuestionListRouteData().go(context);
            case 1:
              const SettingsRouteData().go(context);
          }
        },
      ),
    );
  }
}
