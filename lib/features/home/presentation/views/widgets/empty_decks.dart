import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:gap/gap.dart';

class EmptyDecks extends StatelessWidget {
  const EmptyDecks({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Centered illustration icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                AppIcons.collectionsBookmark,
                color: AppColors.primary,
                size: 48,
              ),
            ),
            const Gap(24),

            // Title
            Text(
              'No Decks Yet',
              style: AppStyles.bold20.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(12),

            // Subtitle description
            Text(
              'Create a flashcard deck to organize your learning and start testing your knowledge!',
              style: AppStyles.regular14.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
