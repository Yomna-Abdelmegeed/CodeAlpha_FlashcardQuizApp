import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:flashcard_quiz_app/core/widgets/error_widget.dart';
import 'package:flashcard_quiz_app/features/study/presentation/view_model/study_cubit.dart';
import 'package:flashcard_quiz_app/features/study/presentation/view_model/study_state.dart';
import 'package:flashcard_quiz_app/features/study/presentation/views/widgets/study_card.dart';
import 'package:flashcard_quiz_app/features/study/presentation/views/widgets/study_navigation.dart';
import 'package:flashcard_quiz_app/features/study/presentation/views/widgets/study_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:gap/gap.dart';

class StudyView extends StatefulWidget {
  final String deckTitle;

  const StudyView({
    super.key,
    this.deckTitle = 'Study',
  });

  @override
  State<StudyView> createState() => _StudyViewState();
}

class _StudyViewState extends State<StudyView> {
  final GestureFlipCardController _flipController = GestureFlipCardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryDark,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.deckTitle,
          style: AppStyles.bold24.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<StudyCubit, StudyState>(
        builder: (context, state) {
          if (state is StudyLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is StudyError) {
            return ErrorScreen(
              onPressed: () {
                // Retry loading
              },
              errorMessage: state.message,
            );
          }

          if (state is StudyEmpty) {
            return _buildEmptyState();
          }

          if (state is StudySuccess) {
            return _buildSuccessBody(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.quiz_outlined,
                color: AppColors.primary,
                size: 48,
              ),
            ),
            const Gap(24),
            Text(
              'No Flashcards Yet',
              style: AppStyles.bold20.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const Gap(12),
            Text(
              'Add flashcards to this deck\nto start studying.',
              style: AppStyles.regular14.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessBody(BuildContext context, StudySuccess state) {
    final cubit = context.read<StudyCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Gap(16),

          // Progress Header
          StudyProgress(
            currentIndex: state.currentIndex,
            totalCards: state.totalCards,
          ),

          const Gap(24),

          // Interactive Flip Card
          Expanded(
            child: StudyCard(
              key: ValueKey(state.currentIndex),
              flashcard: state.currentFlashcard,
              controller: _flipController,
            ),
          ),

          const Gap(24),

          // Navigation Buttons
          StudyNavigation(
            isFirst: state.isFirst,
            isLast: state.isLast,
            onPrevious: () => cubit.previousCard(),
            onNext: () => cubit.nextCard(),
          ),

          const Gap(24),
        ],
      ),
    );
  }
}
