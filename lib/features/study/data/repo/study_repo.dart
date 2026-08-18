import 'package:flashcard_quiz_app/features/deck_details/data/models/flashcard_model.dart';

abstract class StudyRepo {
  Future<List<FlashcardModel>> getFlashcards(String deckId);
}
