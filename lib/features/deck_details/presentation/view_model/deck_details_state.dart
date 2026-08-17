import 'package:flashcard_quiz_app/features/deck_details/data/models/flashcard_model.dart';
import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';

sealed class DeckDetailsState {}

class DeckDetailsInitial extends DeckDetailsState {}

class DeckDetailsLoading extends DeckDetailsState {}

class DeckDetailsSuccess extends DeckDetailsState {
  final DeckModel deck;
  final List<FlashcardModel> flashcards;

  DeckDetailsSuccess({
    required this.deck,
    required this.flashcards,
  });
}

class DeckDetailsError extends DeckDetailsState {
  final String message;

  DeckDetailsError(this.message);
}

class DeckDetailsDeleted extends DeckDetailsState {}
