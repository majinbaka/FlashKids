import 'package:flash_kids/app/presentation/flashcard.dart';
import 'package:flash_kids/app/presentation/kid_zone_scaffold.dart';
import 'package:flash_kids/app/presentation/large_action_button.dart';
import 'package:flash_kids/features/learning/presentation/alphabet_overview_screen.dart';
import 'package:flutter/material.dart';

class AlphabetFlashcardScreen extends StatelessWidget {
  const AlphabetFlashcardScreen({
    required this.title,
    required this.letter,
    required this.position,
    required this.total,
    required this.onRemembered,
    required this.onUnremembered,
    required this.onBack,
    required this.onHome,
    super.key,
  });

  final String title;
  final AlphabetLetter letter;
  final int position;
  final int total;
  final VoidCallback onRemembered;
  final VoidCallback onUnremembered;
  final VoidCallback onBack;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    return KidZoneScaffold(
      title: title,
      onBack: onBack,
      onHome: onHome,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            children: [
              Semantics(
                label: 'Tiến độ học chữ cái',
                value: '$position trên $total',
                child: LinearProgressIndicator(value: position / total),
              ),
              const SizedBox(height: 24),
              Text(
                'Vuốt thẻ hoặc chạm nút',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              _SwipeableLetterCard(
                letter: letter,
                onRemembered: onRemembered,
                onUnremembered: onUnremembered,
              ),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  LargeActionButton(
                    label: 'Chưa nhớ',
                    icon: Icons.close_rounded,
                    filled: false,
                    onPressed: onUnremembered,
                  ),
                  LargeActionButton(
                    label: 'Đã nhớ',
                    icon: Icons.check_rounded,
                    onPressed: onRemembered,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Vuốt trái: Chưa nhớ · Vuốt phải: Đã nhớ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SwipeableLetterCard extends StatelessWidget {
  const _SwipeableLetterCard({
    required this.letter,
    required this.onRemembered,
    required this.onUnremembered,
  });

  final AlphabetLetter letter;
  final VoidCallback onRemembered;
  final VoidCallback onUnremembered;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      hint: 'Vuốt phải để đánh dấu đã nhớ, vuốt trái để đánh dấu chưa nhớ',
      child: Dismissible(
        key: ValueKey(letter.value),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            onRemembered();
          } else {
            onUnremembered();
          }
        },
        background: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Icon(Icons.check_rounded, size: 48),
            ),
          ),
        ),
        secondaryBackground: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.errorContainer,
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Icon(Icons.close_rounded, size: 48),
            ),
          ),
        ),
        child: Flashcard(
          state: FlashcardViewState(
            imageAsset: letter.imageAsset,
            title: letter.value,
            detail: letter.example,
            semanticsLabel: 'Thẻ chữ ${letter.value}. ${letter.example}',
          ),
        ),
      ),
    );
  }
}
