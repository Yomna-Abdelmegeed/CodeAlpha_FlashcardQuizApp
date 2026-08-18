import 'package:flashcard_quiz_app/features/deck_details/presentation/views/deck_details_view.dart';
import 'package:flashcard_quiz_app/features/deck_details/presentation/view_model/deck_details_cubit.dart';
import 'package:flashcard_quiz_app/features/study/presentation/view_model/study_cubit.dart';
import 'package:flashcard_quiz_app/features/home/presentation/views/home_view.dart';
import 'package:flashcard_quiz_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';
import 'package:flashcard_quiz_app/core/di/service_locator.dart';
import 'package:flashcard_quiz_app/features/study/presentation/views/study_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flashcard_quiz_app/core/routes/routes.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: Routes.homeView,
    routes: [
      //* Splash view
      // GoRoute(
      //   path: Routes.splash,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => getIt<SplashCubit>()..getInitData(),
      //     child: const SplashView(),
      //   ),
      // ),

      // * home View
      GoRoute(
        path: Routes.homeView,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<HomeCubit>()..loadDecks(),
          child: const HomeView(),
        ),
      ),

      //* deck details view
      GoRoute(
        path: Routes.deckDetailsView,
        builder: (context, state) {
          final deck = state.extra as DeckModel;
          return BlocProvider(
            create: (context) =>
                getIt<DeckDetailsCubit>()..loadFlashcards(deck),
            child: DeckDetailsView(deck: deck),
          );
        },
      ),

      // * study view
      GoRoute(
        path: Routes.studyView,
        builder: (context, state) {
          final deck = state.extra as DeckModel?;
          return BlocProvider(
            create: (context) =>
                getIt<StudyCubit>()..loadFlashcards(deck?.id ?? ''),
            child: StudyView(deckTitle: deck?.title ?? 'Study'),
          );
        },
      ),
    ],
  );
}
