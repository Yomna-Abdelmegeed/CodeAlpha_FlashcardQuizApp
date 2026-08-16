import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';

void main() {
  group('DeckModel Tests', () {
    test('should serialize to JSON correctly', () {
      const deck = DeckModel(
        id: '123',
        title: 'Test Deck',
        flashcardsCount: 5,
        icon: Icons.book,
      );

      final json = deck.toJson();

      expect(json['id'], '123');
      expect(json['title'], 'Test Deck');
      expect(json['flashcardsCount'], 5);
      expect(json['iconCodePoint'], Icons.book.codePoint);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': '123',
        'title': 'Test Deck',
        'flashcardsCount': 5,
        'iconCodePoint': Icons.book.codePoint,
        'iconFontFamily': Icons.book.fontFamily,
        'iconFontPackage': Icons.book.fontPackage,
        'iconMatchTextDirection': Icons.book.matchTextDirection,
      };

      final deck = DeckModel.fromJson(json);

      expect(deck.id, '123');
      expect(deck.title, 'Test Deck');
      expect(deck.flashcardsCount, 5);
      expect(deck.icon.codePoint, Icons.book.codePoint);
    });
  });
}
