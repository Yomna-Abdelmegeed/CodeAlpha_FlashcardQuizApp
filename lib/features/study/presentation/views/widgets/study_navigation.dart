import 'package:flashcard_quiz_app/core/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:gap/gap.dart';

class StudyNavigation extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const StudyNavigation({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Previous Button
        Expanded(
          child: OutlinedButton(
            onPressed: isFirst ? null : onPrevious,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: isFirst ? AppColors.border : AppColors.primary,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 18,
                  color: isFirst ? AppColors.textHint : AppColors.primary,
                ),
                const Gap(8),
                Text(
                  'Previous',
                  style: AppStyles.bold16.copyWith(
                    color: isFirst ? AppColors.textHint : AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),

        const Gap(16),

        // Next Button
        Expanded(
          child: MainButton(
            onPressed: isLast ? null : onNext,
            icon: Icons.arrow_forward,
            text: 'Next',
            isIconInRight: true,
          ),
        ),
      ],
    );
  }
}
