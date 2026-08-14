import 'package:flashcard_quiz_app/core/common/app_snack_bar.dart';
import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
import 'package:flashcard_quiz_app/core/utils/assets/app_images.dart';
import 'package:flashcard_quiz_app/core/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';
import 'package:flashcard_quiz_app/features/home/presentation/views/widgets/deck_card.dart';
import 'package:flashcard_quiz_app/features/home/presentation/views/widgets/create_deck_dialog.dart';
import 'package:flashcard_quiz_app/features/home/presentation/views/widgets/empty_decks.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<DeckModel> _decks = [
    const DeckModel(
      id: '1',
      title: 'Flutter Basics',
      flashcardsCount: 12,
      icon: AppIcons.style,
    ),
    const DeckModel(
      id: '2',
      title: 'Dart Basics',
      flashcardsCount: 8,
      icon: AppIcons.eco,
    ),
    const DeckModel(
      id: '3',
      title: 'Backend Basics',
      flashcardsCount: 10,
      icon: AppIcons.cloud,
    ),
  ];

  void _showCreateDeckDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateDeckDialog(
          onDeckCreated: (title, icon) {
            setState(() {
              _decks.add(
                DeckModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: title,
                  flashcardsCount: 0,
                  icon: icon,
                ),
              );
            });

            AppSnackBar.success(context, 'Deck "$title" created successfully!');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 90,
        title: Row(
          children: [
            SizedBox(height: 70, child: Image.asset(AppImages.logo)),
            Text(
              'Flasho',
              style: AppStyles.bold32.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            Text(
              'Your Decks',
              style: AppStyles.bold24.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const Gap(20),
            Expanded(
              child: _decks.isEmpty
                  ? const EmptyDecks()
                  : ListView.separated(
                      itemCount: _decks.length,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => const Gap(16),
                      itemBuilder: (context, index) {
                        final deck = _decks[index];
                        return DeckCard(
                          deck: deck,
                          onStudyPressed: () {
                            AppSnackBar.success(
                              context,
                              'Starting study session for "${deck.title}"!',
                            );
                          },
                          onTap: () {
                            AppSnackBar.success(
                              context,
                              'Opened deck: ${deck.title} (${deck.flashcardsCount} cards)',
                            );
                          },
                        );
                      },
                    ),
            ),
            const Gap(16),

            // Pill-shaped New Deck button centered at the bottom
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: MainButton(
                  width: 220,
                  height: 52,
                  onPressed: _showCreateDeckDialog,
                  text: 'New Deck',
                  icon: AppIcons.add,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
