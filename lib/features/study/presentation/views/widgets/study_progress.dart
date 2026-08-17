import 'package:flutter/material.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:gap/gap.dart';

class StudyProgress extends StatelessWidget {
  final int currentIndex;
  final int totalCards;

  const StudyProgress({
    super.key,
    required this.currentIndex,
    required this.totalCards,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalCards == 0 ? 0.0 : (currentIndex + 1) / totalCards;

    return Column(
      children: [
        Text(
          '${currentIndex + 1} / $totalCards',
          style: AppStyles.bold16.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const Gap(12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor: AppColors.border,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ],
    );
  }
}
