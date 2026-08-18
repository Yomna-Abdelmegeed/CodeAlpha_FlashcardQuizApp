import 'package:flashcard_quiz_app/features/deck_details/data/models/flashcard_model.dart';

sealed class StudyState {}

class StudyInitial extends StudyState {}

class StudyLoading extends StudyState {}

class StudyEmpty extends StudyState {}

class StudySuccess extends StudyState {
  final List<FlashcardModel> flashcards;
  final int currentIndex;

  StudySuccess({
    required this.flashcards,
    required this.currentIndex,
  });

  bool get isFirst => currentIndex == 0;
  bool get isLast => currentIndex == flashcards.length - 1;
  FlashcardModel get currentFlashcard => flashcards[currentIndex];
  int get totalCards => flashcards.length;
}

class StudyError extends StudyState {
  final String message;

  StudyError({required this.message});
}
