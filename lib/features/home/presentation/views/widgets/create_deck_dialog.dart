import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
import 'package:flashcard_quiz_app/core/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:gap/gap.dart';

class CreateDeckDialog extends StatefulWidget {
  const CreateDeckDialog({
    super.key,
    required this.onDeckCreated,
  });

  final Function(String title, IconData icon) onDeckCreated;
  @override
  State<CreateDeckDialog> createState() => _CreateDeckDialogState();
}

class _CreateDeckDialogState extends State<CreateDeckDialog> {
  
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<IconData> _availableIcons = [
    AppIcons.style,
    AppIcons.eco,
    AppIcons.cloud,
    AppIcons.code,
    AppIcons.musicNote,
    AppIcons.calculate,
  ];

  late IconData _selectedIcon;

  @override
  void initState() {
    super.initState();
    _selectedIcon = _availableIcons[0];
  }

  @override
  void dispose() {
    _controller.dispose();
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
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Deck',
                style: AppStyles.bold20.copyWith(color: AppColors.textPrimary),
              ),
              const Gap(16),
              Text(
                'Deck Title',
                style: AppStyles.medium15.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Gap(8),

              TextFormField(
                controller: _controller,
                autofocus: true,
                style: AppStyles.regular16.copyWith(
                  color: AppColors.textPrimary,
                ),
                decoration: const InputDecoration(
                  hintText: 'e.g. Flutter Basics',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a deck title';
                  }
                  return null;
                },
              ),
              const Gap(20),

              Text(
                'Select Icon',
                style: AppStyles.medium14.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Gap(10),

              SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _availableIcons.length,
                  separatorBuilder: (context, index) => const Gap(10),
                  itemBuilder: (context, index) {
                    final icon = _availableIcons[index];
                    final isSelected = icon == _selectedIcon;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIcon = icon;
                        });
                      },
                      child: selectedIcon(isSelected: isSelected, icon: icon),
                    );
                  },
                ),
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
                    text: ' Create',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onDeckCreated(
                          _controller.text.trim(),
                          _selectedIcon,
                        );
                        Navigator.pop(context);
                      }
                    },
                    width: 100,
                    height: 35,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container selectedIcon({required bool isSelected, required IconData icon}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: 1.5,
        ),
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : AppColors.textSecondary,
        size: 22,
      ),
    );
  }
}
