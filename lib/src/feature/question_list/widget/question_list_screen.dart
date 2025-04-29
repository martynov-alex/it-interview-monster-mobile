import 'package:flutter/material.dart';

class QuestionListScreen extends StatefulWidget {
  const QuestionListScreen({super.key});

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("QuestionListScreen")));
  }
}
