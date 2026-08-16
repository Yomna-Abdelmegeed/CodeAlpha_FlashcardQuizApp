import 'package:flashcard_quiz_app/core/common/app_dialogs.dart';
import 'package:flashcard_quiz_app/core/common/app_snack_bar.dart';
import 'package:flashcard_quiz_app/core/routes/routes.dart';
import 'package:flashcard_quiz_app/core/utils/assets/app_icons.dart';
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
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DeckDetailsView extends StatefulWidget {
  final DeckModel? deck;

  const DeckDetailsView({super.key, this.deck});

  @override
  State<DeckDetailsView> createState() => _DeckDetailsViewState();
}

class _DeckDetailsViewState extends State<DeckDetailsView> {
  late final DeckModel _currentDeck;
  late final List<FlashcardModel> _flashcards;

  @override
  void initState() {
    super.initState();
    // Default fallback deck if none passed
    _currentDeck =
        widget.deck ??
        const DeckModel(
          id: 'default',
          title: 'Flutter Basics',
          flashcardsCount: 4,
          icon: AppIcons.school,
        );

    // Initial mock data
    _flashcards = [
      const FlashcardModel(
        id: '1',
        question: 'What is Flutter?',
        answer:
            'Flutter is an open-source UI software development kit created by Google.',
      ),
      const FlashcardModel(
        id: '2',
        question: 'What is a Widget?',
        answer:
            'A widget is the basic building block of a Flutter user interface.',
      ),
      const FlashcardModel(
        id: '3',
        question: 'What is BuildContext?',
        answer:
            'BuildContext is a handle to the location of a widget in the widget tree.',
      ),
      const FlashcardModel(
        id: '4',
        question: 'What is StatefulWidget?',
        answer:
            'A widget that has mutable state. Useful for interactive content.',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(16),

            // Deck Summary - "X Flashcards" pill card
            DeckSummary(flashcardsCount: _flashcards.length),

            const Gap(24),

            // Flashcards List
            Expanded(child: _buildFlashcardsList()),
            const Gap(16),

            // Add Flashcard button
            DeckActions(
              onAddFlashcard: _showAddFlashcardDialog,
              onStudy: _flashcards.isEmpty
                  ? null
                  : () => context.push(Routes.studyView),
            ),

            const Gap(24),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          AppIcons.arrowBackIosNew,
          color: AppColors.primaryDark,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        _currentDeck.title,
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
          onPressed: _confirmDeleteDeck,
        ),
      ],
    );
  }

  Widget _buildFlashcardsList() {
    if (_flashcards.isEmpty) {
      return const EmptyFlashcards();
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: _flashcards.length,
      separatorBuilder: (_, _) => const Gap(16),
      itemBuilder: (context, index) {
        final flashcard = _flashcards[index];

        return FlashcardItem(
          flashcard: flashcard,
          onEdit: () => _showEditFlashcardDialog(
            flashcard,
            index,
          ),
          onDelete: () => _confirmDeleteFlashcard(
            index,
          ),
        );
      },
    );
  }

  void _showAddFlashcardDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return FlashcardForm(
          title: 'Add Flashcard',
          onSaved: (question, answer) {
            setState(() {
              _flashcards.add(
                FlashcardModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  question: question,
                  answer: answer,
                ),
              );
            });
            AppSnackBar.success(context, 'Flashcard added successfully!');
          },
        );
      },
    );
  }

  void _showEditFlashcardDialog(FlashcardModel flashcard, int index) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return FlashcardForm(
          title: 'Edit Flashcard',
          initialQuestion: flashcard.question,
          initialAnswer: flashcard.answer,
          onSaved: (question, answer) {
            setState(() {
              _flashcards[index] = FlashcardModel(
                id: flashcard.id,
                question: question,
                answer: answer,
              );
            });
            AppSnackBar.success(context, 'Flashcard updated successfully!');
          },
        );
      },
    );
  }

  void _confirmDeleteFlashcard(int index) {
    return AppDialogs.showAlertDialog(
      context,
      title: 'Delete Flashcard',
      subtitle: 'Are you sure you want to delete this flashcard?',
      ok: 'Delete',
      no: 'Cancel',
      onTap: () {
        setState(() {
          _flashcards.removeAt(index);
        });
        Navigator.pop(context);
        AppSnackBar.success(context, 'Flashcard deleted successfully!');
      },
      onNoTap: () => Navigator.pop(context),
    );
  }

  void _confirmDeleteDeck() {
    AppDialogs.showAlertDialog(
      context,
      title: 'Delete Deck',
      subtitle: 'Are you sure you want to delete this deck?',
      ok: 'Delete',
      no: 'Cancel',
      onTap: () {
        Navigator.pop(context);

        AppSnackBar.success(
          context,
          'Deck deleted successfully!',
        );

        Navigator.pop(context);
      },
      onNoTap: () => Navigator.pop(context),
    );
  }
}
