import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flashcard_quiz_app/features/deck_details/data/models/flashcard_model.dart';
import 'package:flashcard_quiz_app/features/deck_details/data/repo/deck_details_repo.dart';
import 'package:flashcard_quiz_app/features/deck_details/presentation/view_model/deck_details_state.dart';
import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';

class DeckDetailsCubit extends Cubit<DeckDetailsState> {
  final DeckDetailsRepo _deckDetailsRepo;

  DeckDetailsCubit(this._deckDetailsRepo) : super(DeckDetailsInitial());

  Future<void> loadFlashcards(DeckModel deck) async {
    emit(DeckDetailsLoading());
    try {
      final flashcards = await _deckDetailsRepo.getFlashcards(deck.id);

      // Keep deck model count synchronized with flashcards length
      final updatedDeck = DeckModel(
        id: deck.id,
        title: deck.title,
        icon: deck.icon,
        flashcardsCount: flashcards.length,
      );

      emit(DeckDetailsSuccess(deck: updatedDeck, flashcards: flashcards));
    } catch (e) {
      emit(DeckDetailsError(e.toString()));
    }
  }

  Future<void> addFlashcard(
    DeckModel deck,
    String question,
    String answer,
  ) async {
    if (state is! DeckDetailsSuccess) return;
    final currentState = state as DeckDetailsSuccess;

    try {
      final newFlashcard = FlashcardModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        question: question,
        answer: answer,
      );

      final updatedFlashcards = List<FlashcardModel>.from(
        currentState.flashcards,
      )..add(newFlashcard);
      await _deckDetailsRepo.saveFlashcards(deck.id, updatedFlashcards);

      final updatedDeck = DeckModel(
        id: deck.id,
        title: deck.title,
        icon: deck.icon,
        flashcardsCount: updatedFlashcards.length,
      );

      emit(
        DeckDetailsSuccess(deck: updatedDeck, flashcards: updatedFlashcards),
      );
    } catch (e) {
      emit(DeckDetailsError(e.toString()));
    }
  }

  Future<void> updateFlashcard(
    DeckModel deck,
    String flashcardId,
    String question,
    String answer,
  ) async {
    if (state is! DeckDetailsSuccess) return;
    final currentState = state as DeckDetailsSuccess;

    try {
      final updatedFlashcards = currentState.flashcards.map((f) {
        if (f.id == flashcardId) {
          return FlashcardModel(
            id: flashcardId,
            question: question,
            answer: answer,
          );
        }
        return f;
      }).toList();

      await _deckDetailsRepo.saveFlashcards(deck.id, updatedFlashcards);

      final updatedDeck = DeckModel(
        id: deck.id,
        title: deck.title,
        icon: deck.icon,
        flashcardsCount: updatedFlashcards.length,
      );

      emit(
        DeckDetailsSuccess(deck: updatedDeck, flashcards: updatedFlashcards),
      );
    } catch (e) {
      emit(DeckDetailsError(e.toString()));
    }
  }

  Future<void> deleteFlashcard(DeckModel deck, String flashcardId) async {
    if (state is! DeckDetailsSuccess) return;
    final currentState = state as DeckDetailsSuccess;

    try {
      final updatedFlashcards = currentState.flashcards
          .where((f) => f.id != flashcardId)
          .toList();
      await _deckDetailsRepo.saveFlashcards(deck.id, updatedFlashcards);

      final updatedDeck = DeckModel(
        id: deck.id,
        title: deck.title,
        icon: deck.icon,
        flashcardsCount: updatedFlashcards.length,
      );

      emit(
        DeckDetailsSuccess(deck: updatedDeck, flashcards: updatedFlashcards),
      );
    } catch (e) {
      emit(DeckDetailsError(e.toString()));
    }
  }

  Future<void> deleteDeck(String deckId) async {
    emit(DeckDetailsLoading());
    try {
      await _deckDetailsRepo.deleteDeck(deckId);
      emit(DeckDetailsDeleted());
    } catch (e) {
      emit(DeckDetailsError(e.toString()));
    }
  }
}
