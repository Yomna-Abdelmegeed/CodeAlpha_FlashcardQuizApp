import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DeckSummary extends StatelessWidget {
  final int flashcardsCount;

  const DeckSummary({
    super.key,
    required this.flashcardsCount,
  });

  @override
  Widget build(BuildContext context) {
    final label = flashcardsCount == 1 ? 'Flashcard' : 'Flashcards';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withAlpha(35),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            AppIcons.styleOutlined,
            color: AppColors.primary,
          ),
          const Gap(8),
          Text(
            '$flashcardsCount $label',
            style: AppStyles.bold18.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
