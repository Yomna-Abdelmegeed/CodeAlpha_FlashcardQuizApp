import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:flashcard_quiz_app/core/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.onPressed,
    required this.errorMessage,
  });

  final void Function() onPressed;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(AppIcons.error, size: 64, color: AppColors.error),
            const Gap(16),
            Text(
              'Oops! Something went wrong',
              style: AppStyles.bold18.copyWith(color: AppColors.textPrimary),
            ),
            const Gap(8),
            Text(
              errorMessage,
              style: AppStyles.regular14.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            MainButton(
              text: 'Retry',
              onPressed: onPressed,
              width: 140,
              height: 48,
            ),
          ],
        ),
      ),
    );
  }
}
