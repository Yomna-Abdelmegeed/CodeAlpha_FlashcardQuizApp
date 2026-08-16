import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';

abstract class DeckRepo {
  Future<List<DeckModel>> getDecks();
  Future<void> saveDecks(List<DeckModel> decks);
}
