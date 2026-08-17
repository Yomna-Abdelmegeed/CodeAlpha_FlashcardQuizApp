class SharedPrefKeys {
  SharedPrefKeys._();

  static const String decksKey = 'flasho_decks';

  static String flashcardsKey(String deckId) => 'flasho_flashcards_$deckId';
}
