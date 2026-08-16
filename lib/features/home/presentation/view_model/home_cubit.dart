import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';
import 'package:flashcard_quiz_app/features/home/data/repo/deck_repo.dart';
import 'package:flashcard_quiz_app/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final DeckRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(HomeInitial());

  Future<void> loadDecks() async {
    emit(HomeLoading());
    try {
      final decks = await _homeRepo.getDecks();
      emit(HomeSuccess(decks));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> addDeck(DeckModel deck) async {
    List<DeckModel> currentDecks = [];
    if (state is HomeSuccess) {
      currentDecks = (state as HomeSuccess).decks;
    } else {
      try {
        currentDecks = await _homeRepo.getDecks();
      } catch (_) {
        currentDecks = [];
      }
    }

    final updatedDecks = List<DeckModel>.from(currentDecks)..add(deck);
    try {
      await _homeRepo.saveDecks(updatedDecks);
      emit(HomeSuccess(updatedDecks));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}