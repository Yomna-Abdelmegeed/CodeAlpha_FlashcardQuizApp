import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:flashcard_quiz_app/core/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DeckActions extends StatelessWidget {
  final VoidCallback onAddFlashcard;
  final VoidCallback? onStudy;

  const DeckActions({
    super.key,
    required this.onAddFlashcard,
    required this.onStudy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: onAddFlashcard,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                AppIcons.add,
                color: AppColors.primary,
                size: 22,
              ),
              const Gap(8),
              Text(
                'Add Flashcard',
                style: AppStyles.bold16.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const Gap(12),
        MainButton(
          text: 'Study Deck',
          icon: AppIcons.playArrow,
          onPressed: onStudy,
        ),
      ],
    );
  }
}
