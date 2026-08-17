import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:flashcard_quiz_app/features/deck_details/data/models/flashcard_model.dart';
import 'package:flashcard_quiz_app/features/study/presentation/views/widgets/study_card.dart';
import 'package:flashcard_quiz_app/features/study/presentation/views/widgets/study_navigation.dart';
import 'package:flashcard_quiz_app/features/study/presentation/views/widgets/study_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:gap/gap.dart';

class StudyView extends StatefulWidget {
  const StudyView({super.key});

  @override
  State<StudyView> createState() => _StudyViewState();
}

class _StudyViewState extends State<StudyView> {
  int _currentIndex = 0;
  final GestureFlipCardController _flipController = GestureFlipCardController();

  final List<FlashcardModel> _mockFlashcards = const [
    FlashcardModel(
      id: '1',
      question: 'What is Flutter?',
      answer:
          'Flutter is an open-source UI toolkit created by Google for building natively compiled applications.',
    ),
    FlashcardModel(
      id: '2',
      question: 'What is a Widget?',
      answer:
          'A widget is the basic building block of a Flutter user interface.',
    ),
    FlashcardModel(
      id: '3',
      question: 'What is BuildContext?',
      answer:
          'BuildContext is a handle to the location of a widget in the widget tree.',
    ),
    FlashcardModel(
      id: '4',
      question: 'What is StatefulWidget?',
      answer:
          'A widget that has mutable state. Useful for interactive and dynamic content.',
    ),
  ];

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _nextCard() {
    if (_currentIndex < _mockFlashcards.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            AppIcons.arrowBackIosNew,
            color: AppColors.primaryDark,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Flutter Basics',
          style: AppStyles.bold24.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Gap(16),

            // Progress Header
            StudyProgress(
              currentIndex: _currentIndex,
              totalCards: _mockFlashcards.length,
            ),

            const Gap(24),

            // Interactive Flip Card
            Expanded(
              child: StudyCard(
                key: ValueKey(_currentIndex),
                flashcard: _mockFlashcards[_currentIndex],
                controller: _flipController,
              ),
            ),

            const Gap(24),

            // Navigation Buttons
            StudyNavigation(
              isFirst: _currentIndex == 0,
              isLast: _currentIndex == _mockFlashcards.length - 1,
              onPrevious: _previousCard,
              onNext: _nextCard,
            ),

            const Gap(32),
          ],
        ),
      ),
    );
  }
}
