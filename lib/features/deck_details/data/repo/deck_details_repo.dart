import 'package:flashcard_quiz_app/features/deck_details/data/models/flashcard_model.dart';

abstract class DeckDetailsRepo {
  Future<List<FlashcardModel>> getFlashcards(String deckId);
  Future<void> saveFlashcards(String deckId, List<FlashcardModel> flashcards);
  Future<void> deleteDeck(String deckId);
}
