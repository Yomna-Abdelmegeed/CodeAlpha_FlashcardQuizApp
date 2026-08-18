import 'package:flashcard_quiz_app/core/services/network/api_consumer.dart';
import 'package:flashcard_quiz_app/core/services/network/dio_consumer.dart';
import 'package:flashcard_quiz_app/features/home/data/repo/deck_repo.dart';
import 'package:flashcard_quiz_app/features/home/data/repo/deck_repo_impl.dart';
import 'package:flashcard_quiz_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:flashcard_quiz_app/features/deck_details/data/repo/deck_details_repo.dart';
import 'package:flashcard_quiz_app/features/deck_details/data/repo/deck_details_repo_impl.dart';
import 'package:flashcard_quiz_app/features/deck_details/presentation/view_model/deck_details_cubit.dart';
import 'package:flashcard_quiz_app/features/study/data/repo/study_repo.dart';
import 'package:flashcard_quiz_app/features/study/data/repo/study_repo_impl.dart';
import 'package:flashcard_quiz_app/features/study/presentation/view_model/study_cubit.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

/// This file is responsible for registering all the services
/// that will be used in the app using GetIt package for [dependency_injection].
final GetIt getIt = GetIt.instance;

//* This function will be called in the main function before running the app
void setupServiceLocator() {
  //! shared network services
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(getIt<Dio>()));

  //! Home Feature
  getIt.registerLazySingleton<DeckRepo>(
    () => DeckRepoImpl(),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<DeckRepo>()));

  //! Deck Details Feature
  getIt.registerLazySingleton<DeckDetailsRepo>(
    () => DeckDetailsRepoImpl(),
  );
  getIt.registerFactory<DeckDetailsCubit>(
    () => DeckDetailsCubit(getIt<DeckDetailsRepo>()),
  );

  //! Study Feature
  getIt.registerLazySingleton<StudyRepo>(
    () => StudyRepoImpl(),
  );
  getIt.registerFactory<StudyCubit>(
    () => StudyCubit(getIt<StudyRepo>()),
  );

  //? Splash Cubit
  // getIt.registerFactory<SplashCubit>(
  //   () => SplashCubit(profileRepo: getIt<ProfileRepo>()),
  // );

  // //! Test Feature
  // getIt.registerLazySingleton<TestRepo>(
  //   () => TestRepoImpl(getIt<ApiConsumer>()),
  // );
  // getIt.registerFactory<TestCubit>(() => TestCubit(getIt<TestRepo>()));
}
