import 'package:flashcard_quiz_app/app/app_initializer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flashcard_quiz_app/app/app.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize app services
  await AppInitializer.init();
  // Set the app to immersive sticky mode to hide system UI elements
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
    DevicePreview(
      enabled: false, //kDebugMode,
      builder: (context) => const FlashcardQuizApp(),
    ),
  );
}
