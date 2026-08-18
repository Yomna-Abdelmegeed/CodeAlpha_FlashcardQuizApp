import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flashcard_quiz_app/features/study/data/repo/study_repo.dart';
import 'package:flashcard_quiz_app/features/study/presentation/view_model/study_state.dart';

class StudyCubit extends Cubit<StudyState> {
  final StudyRepo _studyRepo;

  StudyCubit(this._studyRepo) : super(StudyInitial());

  Future<void> loadFlashcards(String deckId) async {
    emit(StudyLoading());
    try {
      final flashcards = await _studyRepo.getFlashcards(deckId);
      if (flashcards.isEmpty) {
        emit(StudyEmpty());
      } else {
        emit(
          StudySuccess(
            flashcards: flashcards,
            currentIndex: 0,
          ),
        );
      }
    } catch (e) {
      emit(StudyError(message: e.toString()));
    }
  }

  void nextCard() {
    if (state is StudySuccess) {
      final currentState = state as StudySuccess;
      if (currentState.currentIndex < currentState.totalCards - 1) {
        emit(
          StudySuccess(
            flashcards: currentState.flashcards,
            currentIndex: currentState.currentIndex + 1,
          ),
        );
      }
    }
  }

  void previousCard() {
    if (state is StudySuccess) {
      final currentState = state as StudySuccess;
      if (currentState.currentIndex > 0) {
        emit(
          StudySuccess(
            flashcards: currentState.flashcards,
            currentIndex: currentState.currentIndex - 1,
          ),
        );
      }
    }
  }
}
