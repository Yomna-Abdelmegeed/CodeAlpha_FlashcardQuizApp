import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
import 'package:flashcard_quiz_app/core/widgets/empty_widget.dart';
import 'package:flutter/material.dart';

class EmptyDecks extends StatelessWidget {
  const EmptyDecks({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyWidget(
      icon: AppIcons.collectionsBookmark,
      title: 'No Decks Yet',
      description:
          'Create a flashcard deck to organize your learning and start testing your knowledge!',
    );
  }
}
