import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:flashcard_quiz_app/features/deck_details/data/models/flashcard_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FlashcardItem extends StatelessWidget {
  final FlashcardModel flashcard;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const FlashcardItem({
    super.key,
    required this.flashcard,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 6, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question & answer text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  flashcard.question,
                  style: AppStyles.bold15.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(4),
                Text(
                  flashcard.answer,
                  style: AppStyles.regular14.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // More actions menu
          PopupMenuButton<String>(
            icon: const Icon(
              AppIcons.moreVert,
              color: AppColors.textHint,
              size: 20,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: AppColors.surface,
            elevation: 4,
            onSelected: (value) {
              if (value == 'edit') {
                onEdit.call();
              } else if (value == 'delete') {
                onDelete.call();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    const Icon(
                      AppIcons.edit,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                    const Gap(10),
                    Text(
                      'Edit',
                      style: AppStyles.medium14.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(
                      AppIcons.delete,
                      size: 18,
                      color: AppColors.error,
                    ),
                    const Gap(10),
                    Text(
                      'Delete',
                      style: AppStyles.medium14.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
