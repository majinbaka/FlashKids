import 'package:flash_kids/app/presentation/kid_zone_scaffold.dart';
import 'package:flash_kids/app/presentation/large_action_button.dart';
import 'package:flutter/material.dart';

@immutable
class AlphabetLetter {
  const AlphabetLetter({required this.value, required this.example});

  final String value;
  final String example;

  String get imageAsset =>
      'assets/images/alphabet/alphabet-${value.toLowerCase()}.png';
}

class AlphabetOverviewScreen extends StatelessWidget {
  const AlphabetOverviewScreen({
    required this.title,
    required this.letters,
    required this.rememberedLetters,
    required this.onLetterSelected,
    required this.onStudyAll,
    required this.onStudyUnremembered,
    required this.onBack,
    required this.onHome,
    super.key,
  });

  final String title;
  final List<AlphabetLetter> letters;
  final Set<String> rememberedLetters;
  final ValueChanged<AlphabetLetter> onLetterSelected;
  final VoidCallback onStudyAll;
  final VoidCallback onStudyUnremembered;
  final VoidCallback onBack;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final unrememberedCount = letters
        .where((letter) => !rememberedLetters.contains(letter.value))
        .length;
    return KidZoneScaffold(
      title: title,
      onBack: onBack,
      onHome: onHome,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            children: [
              Text(
                'Chọn chữ để bắt đầu',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Hoặc chọn một cách học',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final letter in letters)
                    _AlphabetLetterTile(
                      letter: letter,
                      isRemembered: rememberedLetters.contains(letter.value),
                      onPressed: () => onLetterSelected(letter),
                    ),
                ],
              ),
              const SizedBox(height: 28),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  LargeActionButton(
                    label: 'Học tất cả',
                    icon: Icons.auto_stories_rounded,
                    onPressed: onStudyAll,
                  ),
                  LargeActionButton(
                    label: 'Học chữ chưa nhớ ($unrememberedCount)',
                    icon: Icons.refresh_rounded,
                    filled: false,
                    onPressed: unrememberedCount == 0
                        ? null
                        : onStudyUnremembered,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlphabetLetterTile extends StatelessWidget {
  const _AlphabetLetterTile({
    required this.letter,
    required this.isRemembered,
    required this.onPressed,
  });

  final AlphabetLetter letter;
  final bool isRemembered;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isRemembered,
      label: isRemembered
          ? 'Chữ ${letter.value}, đã nhớ'
          : 'Chữ ${letter.value}, chưa nhớ',
      child: SizedBox(
        width: 76,
        height: 84,
        child: FilledButton.tonal(
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                letter.value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                isRemembered
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
