import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flashcard_quiz_app/core/routes/app_router.dart';
import 'package:flashcard_quiz_app/core/utils/themes/app_themes.dart';

class FlashcardQuizApp extends StatelessWidget {
  const FlashcardQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: SafeArea(
            top: false,
            bottom: Platform.isAndroid,
            child: child!,
          ),
        );
      },
    );
  }
}
