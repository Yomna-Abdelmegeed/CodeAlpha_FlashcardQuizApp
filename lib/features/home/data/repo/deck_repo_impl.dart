import 'package:flashcard_quiz_app/core/services/cache/shred_pref/shared_pref_keys.dart';
import 'package:flashcard_quiz_app/core/services/cache/shred_pref/shared_pref_service.dart';
import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';
import 'package:flashcard_quiz_app/features/home/data/repo/deck_repo.dart';

class DeckRepoImpl implements DeckRepo {
  @override
  Future<List<DeckModel>> getDecks() async {
    try {
      final data = SharedPrefService.getJson(
        key: SharedPrefKeys.decksKey,
      );

      if (data == null) {
        return [];
      }

      return (data as List)
          .map(
            (item) => DeckModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to load decks: $e');
    }
  }

  @override
  Future<void> saveDecks(List<DeckModel> decks) async {
    try {
      await SharedPrefService.setJson(
        key: SharedPrefKeys.decksKey,
        value: decks.map((deck) => deck.toJson()).toList(),
      );
    } catch (e) {
      throw Exception('Failed to save decks: $e');
    }
  }
}
