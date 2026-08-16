import 'package:flashcard_quiz_app/core/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:gap/gap.dart';

class FlashcardForm extends StatefulWidget {
  final String? initialQuestion;
  final String? initialAnswer;
  final String title;
  final Function(String question, String answer) onSaved;

  const FlashcardForm({
    super.key,
    this.initialQuestion,
    this.initialAnswer,
    required this.title,
    required this.onSaved,
  });

  @override
  State<FlashcardForm> createState() => _FlashcardFormState();
}

class _FlashcardFormState extends State<FlashcardForm> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _questionController.text = widget.initialQuestion ?? '';
    _answerController.text = widget.initialAnswer ?? '';
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: AppStyles.bold20.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const Gap(16),

                // Question Input
                Text(
                  'Question',
                  style: AppStyles.medium15.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const Gap(8),
                TextFormField(
                  controller: _questionController,
                  autofocus: true,
                  maxLines: 2,
                  style: AppStyles.regular16.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'e.g. What is BuildContext?',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a question';
                    }
                    return null;
                  },
                ),
                const Gap(20),

                // Answer Input
                Text(
                  'Answer',
                  style: AppStyles.medium15.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const Gap(8),
                TextFormField(
                  controller: _answerController,
                  maxLines: 3,
                  style: AppStyles.regular16.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: const InputDecoration(
                    hintText:
                        'e.g. BuildContext is a handle to the location of a widget...',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an answer';
                    }
                    return null;
                  },
                ),
                const Gap(28),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: AppStyles.bold14,
                      ),
                    ),
                    const Gap(12),
                    MainButton(
                      width: 100,
                      height: 35,
                      text: 'Save',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onSaved(
                            _questionController.text.trim(),
                            _answerController.text.trim(),
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
