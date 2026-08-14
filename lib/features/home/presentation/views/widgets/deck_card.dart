import 'package:flashcard_quiz_app/core/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';
import 'package:gap/gap.dart';

class DeckCard extends StatelessWidget {
  final DeckModel deck;
  final VoidCallback onStudyPressed;
  final VoidCallback onTap;

  const DeckCard({
    super.key,
    required this.deck,
    required this.onStudyPressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                deck.icon,
                color: AppColors.background,
                size: 26,
              ),
            ),
            const Gap(16),

            // Text info
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deck.title,
                    style: AppStyles.bold16.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  Text(
                    '${deck.flashcardsCount} Flashcards',
                    style: AppStyles.medium12.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8),

            // Study button
            MainButton(
              text: 'Study',
              onPressed: onStudyPressed,
              width: 80,
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
