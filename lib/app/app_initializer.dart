import 'package:flashcard_quiz_app/core/services/cache/secure_storage/secure_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flashcard_quiz_app/core/services/cache/shred_pref/shared_pref_service.dart';
import 'package:flashcard_quiz_app/core/logging/app_bloc_observer.dart';
import 'package:flashcard_quiz_app/core/di/service_locator.dart';
import '../core/logging/app_logger.dart';

class AppInitializer {
  AppInitializer._();

  /// This method is called ONCE when the app starts
  /// It prepares all services the app depends on
  static Future<void> init() async {
    try {
      //* (1) Initialize logger first
      // So we can log messages during app startup
      _initLogger();

      //* (2) Setup Bloc observer
      _initBlocObserver();

      //* (3) Initialize app storage systems
      // SharedPreferences, SecureStorage
      await _initAppStorage();

      //* (4) Setup service locator (GetIt)
      // Registers all app services and dependencies
      _initServiceLocator();

      //* Final success log
      AppLogger.success(
        'Application initialized successfully',
        tag: 'AppInitializer',
      );
    } catch (e, stackTrace) {
      //! If ANY error happens during initialization, log it and rethrow
      AppLogger.error(
        'Application initialization failed',
        error: e,
        stackTrace: stackTrace,
        tag: 'AppInitializer',
      );
      rethrow;
    }
  }

  //! =========================
  //! Private helper methods
  //! =========================
  static Future<void> _initAppStorage() async {
    // (1) Initialize SharedPreferences
    await _initSharedPreferences();

    /// (2) Check that secure storage is available
    await SecureStorageService.instance.init();
  }

  /// Initializes [SharedPreferences] using your helper
  /// Used for lightweight cached data (flags, settings, etc.)
  static Future<void> _initSharedPreferences() async {
    await SharedPrefService.init();

    AppLogger.success(
      'SharedPreferences initialized successfully',
      tag: 'SharedPreferences',
    );
  }

  /// Initializes the global [BlocObserver] for logging Cubit and Bloc lifecycle events
  static void _initBlocObserver() {
    Bloc.observer = AppBlocObserver();

    AppLogger.success('Bloc observer initialized', tag: 'BlocObserver');
  }

  /// Configures [logging_behavior]
  /// Logs are enabled only in debug mode
  static void _initLogger() {
    // Enable logs in debug mode
    // Disable logs in release mode
    AppLogger.setEnabled(kDebugMode);

    AppLogger.success('Logger initialized', tag: 'Logger');
  }

  /// Initializes the service locator [GetIt]
  /// Registers all app services and dependencies
  static void _initServiceLocator() {
    setupServiceLocator();

    AppLogger.success('Service locator initialized successfully', tag: 'GetIt');
  }
}
