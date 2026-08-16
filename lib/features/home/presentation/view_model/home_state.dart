import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<DeckModel> decks;

  HomeSuccess(this.decks);
}

final class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}