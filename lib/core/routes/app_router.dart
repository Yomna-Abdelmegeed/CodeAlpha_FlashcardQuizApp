import 'package:flashcard_quiz_app/features/deck_details/presentation/views/deck_details_view.dart';
import 'package:flashcard_quiz_app/features/home/presentation/views/home_view.dart';
import 'package:flashcard_quiz_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:flashcard_quiz_app/core/di/service_locator.dart';
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

      // deck details view
      GoRoute(
        path: Routes.deckDetailsView,
        builder: (context, state) => const DeckDetailsView(),
      ),
    ],
  );
}
