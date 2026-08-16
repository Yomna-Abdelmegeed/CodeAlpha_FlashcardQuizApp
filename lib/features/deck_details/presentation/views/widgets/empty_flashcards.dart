import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
import 'package:flashcard_quiz_app/core/widgets/empty_widget.dart';
import 'package:flutter/material.dart';

class EmptyFlashcards extends StatelessWidget {
  const EmptyFlashcards({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyWidget(
      icon: AppIcons.quiz,
      title: 'No Flashcards Yet',
      description: 'Add your first flashcard\nto start studying.',
    );
  }
}
