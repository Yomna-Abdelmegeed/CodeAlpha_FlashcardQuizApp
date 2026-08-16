import 'package:flashcard_quiz_app/core/common/app_snack_bar.dart';
import 'package:flashcard_quiz_app/core/routes/routes.dart';
import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
import 'package:flashcard_quiz_app/core/utils/assets/app_images.dart';
import 'package:flashcard_quiz_app/core/widgets/buttons/main_button.dart';
import 'package:flashcard_quiz_app/core/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';
import 'package:flashcard_quiz_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:flashcard_quiz_app/features/home/presentation/view_model/home_state.dart';
import 'package:flashcard_quiz_app/features/home/presentation/views/widgets/deck_card.dart';
import 'package:flashcard_quiz_app/features/home/presentation/views/widgets/create_deck_dialog.dart';
import 'package:flashcard_quiz_app/features/home/presentation/views/widgets/empty_decks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _showCreateDeckDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CreateDeckDialog(
          onDeckCreated: (title, icon) {
            final newDeck = DeckModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: title,
              flashcardsCount: 0,
              icon: icon,
            );

            context.read<HomeCubit>().addDeck(newDeck);

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
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  } else if (state is HomeError) {
                    return ErrorScreen(
                      onPressed: () {
                        context.read<HomeCubit>().loadDecks();
                      },
                      errorMessage: state.message,
                    );
                  } else if (state is HomeSuccess) {
                    final decks = state.decks;
                    if (decks.isEmpty) {
                      return const EmptyDecks();
                    }
                    return ListView.separated(
                      itemCount: decks.length,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => const Gap(16),
                      itemBuilder: (context, index) {
                        final deck = decks[index];
                        return DeckCard(
                          deck: deck,
                          onStudyPressed: () {
                            AppSnackBar.success(
                              context,
                              'Starting study session for "${deck.title}"!',
                            );
                          },
                          onTap: () {
                            context.push(Routes.deckDetailsView, extra: deck);

                            AppSnackBar.success(
                              context,
                              'Opened deck: ${deck.title} (${deck.flashcardsCount} cards)',
                            );
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
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
                  onPressed: () => _showCreateDeckDialog(context),
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
