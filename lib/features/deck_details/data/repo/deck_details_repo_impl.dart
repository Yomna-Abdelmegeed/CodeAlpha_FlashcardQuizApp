import 'package:flashcard_quiz_app/core/services/cache/shred_pref/shared_pref_keys.dart';
import 'package:flashcard_quiz_app/core/services/cache/shred_pref/shared_pref_service.dart';
import 'package:flashcard_quiz_app/features/deck_details/data/models/flashcard_model.dart';
import 'package:flashcard_quiz_app/features/deck_details/data/repo/deck_details_repo.dart';
import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';

class DeckDetailsRepoImpl implements DeckDetailsRepo {
  @override
  Future<List<FlashcardModel>> getFlashcards(String deckId) async {
    try {
      final data = SharedPrefService.getJson(
        key: SharedPrefKeys.flashcardsKey(deckId),
      );

      if (data == null) {
        return [];
      }

      return (data as List)
          .map(
            (item) => FlashcardModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to load flashcards: $e');
    }
  }

  @override
  Future<void> saveFlashcards(
    String deckId,
    List<FlashcardModel> flashcards,
  ) async {
    try {
      // 1. Save the list of flashcards under the deck-specific key
      await SharedPrefService.setJson(
        key: SharedPrefKeys.flashcardsKey(deckId),
        value: flashcards.map((f) => f.toJson()).toList(),
      );

      // 2. Load the list of decks
      final decksData = SharedPrefService.getJson(
        key: SharedPrefKeys.decksKey,
      );

      if (decksData != null) {
        final decks = (decksData as List)
            .map((item) => DeckModel.fromJson(item as Map<String, dynamic>))
            .toList();

        // 3. Find the deck with deckId and update its flashcardsCount
        final deckIndex = decks.indexWhere((d) => d.id == deckId);
        if (deckIndex != -1) {
          final updatedDeck = DeckModel(
            id: decks[deckIndex].id,
            title: decks[deckIndex].title,
            icon: decks[deckIndex].icon,
            flashcardsCount: flashcards.length,
          );
          decks[deckIndex] = updatedDeck;

          // 4. Save the updated list of decks
          await SharedPrefService.setJson(
            key: SharedPrefKeys.decksKey,
            value: decks.map((d) => d.toJson()).toList(),
          );
        }
      }
    } catch (e) {
      throw Exception('Failed to save flashcards: $e');
    }
  }

  @override
  Future<void> deleteDeck(String deckId) async {
    try {
      // 1. Remove the flashcards for this deck from local storage
      await SharedPrefService.removeData(
        key: SharedPrefKeys.flashcardsKey(deckId),
      );

      // 2. Load the list of decks
      final decksData = SharedPrefService.getJson(
        key: SharedPrefKeys.decksKey,
      );

      if (decksData != null) {
        final decks = (decksData as List)
            .map((item) => DeckModel.fromJson(item as Map<String, dynamic>))
            .toList();

        // 3. Remove the deck with deckId
        decks.removeWhere((d) => d.id == deckId);

        // 4. Save the updated list of decks
        await SharedPrefService.setJson(
          key: SharedPrefKeys.decksKey,
          value: decks.map((d) => d.toJson()).toList(),
        );
      }
    } catch (e) {
      throw Exception('Failed to delete deck: $e');
    }
  }
}
