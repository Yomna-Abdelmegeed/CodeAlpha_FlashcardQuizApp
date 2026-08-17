import 'package:flashcard_quiz_app/core/common/app_dialogs.dart';
import 'package:flashcard_quiz_app/core/common/app_snack_bar.dart';
import 'package:flashcard_quiz_app/core/routes/routes.dart';
import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
import 'package:flashcard_quiz_app/core/widgets/error_widget.dart';
import 'package:flashcard_quiz_app/features/deck_details/presentation/view_model/deck_details_cubit.dart';
import 'package:flashcard_quiz_app/features/deck_details/presentation/view_model/deck_details_state.dart';
import 'package:flashcard_quiz_app/features/deck_details/presentation/views/widgets/deck_actions.dart';
import 'package:flashcard_quiz_app/features/deck_details/presentation/views/widgets/deck_summary.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_quiz_app/core/utils/colors/app_colors.dart';
import 'package:flashcard_quiz_app/core/utils/styles/app_styles.dart';
import 'package:flashcard_quiz_app/features/home/data/models/deck_model.dart';
import 'package:flashcard_quiz_app/features/deck_details/data/models/flashcard_model.dart';
import 'package:flashcard_quiz_app/features/deck_details/presentation/views/widgets/flashcard_item.dart';
import 'package:flashcard_quiz_app/features/deck_details/presentation/views/widgets/empty_flashcards.dart';
import 'package:flashcard_quiz_app/features/deck_details/presentation/views/widgets/flashcard_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DeckDetailsView extends StatelessWidget {
  final DeckModel deck;

  const DeckDetailsView({super.key, required this.deck});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeckDetailsCubit, DeckDetailsState>(
      listener: (context, state) {
        if (state is DeckDetailsDeleted) {
          AppSnackBar.success(context, 'Deck deleted successfully!');
          Navigator.pop(context);
        } else if (state is DeckDetailsError) {
          AppSnackBar.error(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context, state),
          body: _buildBody(context, state),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    DeckDetailsState state,
  ) {
    // Use the deck title from the success state if available
    final title = state is DeckDetailsSuccess ? state.deck.title : deck.title;

    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          AppIcons.arrowBackIosNew,
          color: AppColors.primaryDark,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: AppStyles.bold24.copyWith(
          color: AppColors.primaryDark,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            AppIcons.delete,
            color: AppColors.error,
          ),
          onPressed: () => _confirmDeleteDeck(context),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, DeckDetailsState state) {
    if (state is DeckDetailsLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state is DeckDetailsError) {
      return ErrorScreen(
        onPressed: () {
          context.read<DeckDetailsCubit>().loadFlashcards(deck);
        },
        errorMessage: state.message,
      );
    }

    if (state is DeckDetailsSuccess) {
      return _buildSuccessBody(context, state);
    }

    // Initial / fallback
    return const SizedBox.shrink();
  }

  Widget _buildSuccessBody(BuildContext context, DeckDetailsSuccess state) {
    final flashcards = state.flashcards;
    final currentDeck = state.deck;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(16),

          // Deck Summary - "X Flashcards" pill card
          DeckSummary(flashcardsCount: flashcards.length),

          const Gap(24),

          // Flashcards List
          Expanded(
            child: _buildFlashcardsList(context, currentDeck, flashcards),
          ),
          const Gap(16),

          // Add Flashcard button + Study Deck button
          DeckActions(
            onAddFlashcard: () => _showFlashcardForm(context, currentDeck),
            onStudy: flashcards.isEmpty
                ? null
                : () => context.push(Routes.studyView),
          ),

          const Gap(24),
        ],
      ),
    );
  }

  Widget _buildFlashcardsList(
    BuildContext context,
    DeckModel currentDeck,
    List<FlashcardModel> flashcards,
  ) {
    if (flashcards.isEmpty) {
      return const EmptyFlashcards();
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: flashcards.length,
      separatorBuilder: (_, _) => const Gap(16),
      itemBuilder: (context, index) {
        final flashcard = flashcards[index];

        return FlashcardItem(
          flashcard: flashcard,
          onEdit: () => _showFlashcardForm(
            context,
            currentDeck,
            flashcard: flashcard,
          ),
          onDelete: () => _confirmDeleteFlashcard(
            context,
            currentDeck,
            flashcard,
          ),
        );
      },
    );
  }

  //* Shows the Add/Edit flashcard dialog.
  // Pass [flashcard] when editing; omit when adding.
  void _showFlashcardForm(
    BuildContext context,
    DeckModel currentDeck, {
    FlashcardModel? flashcard,
  }) {
    final isEditing = flashcard != null;
    final cubit = context.read<DeckDetailsCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return FlashcardForm(
          title: isEditing ? 'Edit Flashcard' : 'Add Flashcard',
          initialQuestion: flashcard?.question,
          initialAnswer: flashcard?.answer,
          onSaved: (question, answer) {
            if (isEditing) {
              cubit.updateFlashcard(
                currentDeck,
                flashcard.id,
                question,
                answer,
              );
              AppSnackBar.success(context, 'Flashcard updated successfully!');
            } else {
              cubit.addFlashcard(currentDeck, question, answer);
              AppSnackBar.success(context, 'Flashcard added successfully!');
            }
          },
        );
      },
    );
  }

  void _confirmDeleteFlashcard(
    BuildContext context,
    DeckModel currentDeck,
    FlashcardModel flashcard,
  ) {
    final cubit = context.read<DeckDetailsCubit>();

    AppDialogs.showAlertDialog(
      context,
      title: 'Delete Flashcard',
      subtitle: 'Are you sure you want to delete this flashcard?',
      ok: 'Delete',
      no: 'Cancel',
      onTap: () {
        cubit.deleteFlashcard(currentDeck, flashcard.id);
        Navigator.pop(context);
        AppSnackBar.success(context, 'Flashcard deleted successfully!');
      },
      onNoTap: () => Navigator.pop(context),
    );
  }

  void _confirmDeleteDeck(BuildContext context) {
    final cubit = context.read<DeckDetailsCubit>();

    AppDialogs.showAlertDialog(
      context,
      title: 'Delete Deck',
      subtitle: 'Are you sure you want to delete this deck?',
      ok: 'Delete',
      no: 'Cancel',
      onTap: () {
        Navigator.pop(context); // Close the dialog first
        cubit.deleteDeck(deck.id);
        // Navigation back happens in BlocConsumer listener on DeckDetailsDeleted
      },
      onNoTap: () => Navigator.pop(context),
    );
  }
}
