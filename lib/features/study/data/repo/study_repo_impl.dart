import 'package:flashcard_quiz_app/core/services/cache/shred_pref/shared_pref_keys.dart';
import 'package:flashcard_quiz_app/core/services/cache/shred_pref/shared_pref_service.dart';
import 'package:flashcard_quiz_app/features/deck_details/data/models/flashcard_model.dart';
import 'package:flashcard_quiz_app/features/study/data/repo/study_repo.dart';

class StudyRepoImpl implements StudyRepo {
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
      throw Exception('Failed to load flashcards for study: $e');
    }
  }
}
