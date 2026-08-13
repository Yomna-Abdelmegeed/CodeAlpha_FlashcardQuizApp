import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconColor = Colors.white,
    this.textColor = Colors.white,
    this.gradientColors,
    this.width = double.infinity,
    this.height = 56,
    this.borderRadius = 14,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;

  final IconData? icon;
  final Color iconColor;
  final Color textColor;

  final List<Color>? gradientColors;

  final double width;
  final double height;
  final double borderRadius;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ?? [AppColors.primary, AppColors.secondary];

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.20),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: textColor,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 21, color: iconColor),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      text,
                      style: AppStyles.bold18.copyWith(color: textColor),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
