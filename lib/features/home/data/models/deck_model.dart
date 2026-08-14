import 'package:flutter/material.dart';

class DeckModel {
  final String id;
  final String title;
  final int flashcardsCount;
  final IconData icon;

  const DeckModel({
    required this.id,
    required this.title,
    required this.flashcardsCount,
    required this.icon,
  });
}
