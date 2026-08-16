// ignore_for_file: non_const_argument_for_const_parameter
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'flashcardsCount': flashcardsCount,
      'iconCodePoint': icon.codePoint,
      'iconFontFamily': icon.fontFamily,
      'iconFontPackage': icon.fontPackage,
      'iconMatchTextDirection': icon.matchTextDirection,
    };
  }

  factory DeckModel.fromJson(Map<String, dynamic> json) {
    return DeckModel(
      id: json['id'] as String,
      title: json['title'] as String,
      flashcardsCount: json['flashcardsCount'] as int,
      icon: IconData(
        json['iconCodePoint'] as int,
        fontFamily: json['iconFontFamily'] as String?,
        fontPackage: json['iconFontPackage'] as String?,
        matchTextDirection: json['iconMatchTextDirection'] as bool? ?? false,
      ),
    );
  }
}
