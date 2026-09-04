import 'package:flutter/material.dart';

@immutable
class FlashcardViewState {
  const FlashcardViewState({
    required this.imageAsset,
    required this.title,
    required this.detail,
    required this.semanticsLabel,
  });

  final String imageAsset;
  final String title;
  final String detail;
  final String semanticsLabel;
}

class Flashcard extends StatelessWidget {
  const Flashcard({required this.state, super.key});

  final FlashcardViewState state;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: state.semanticsLabel,
      excludeSemantics: true,
      child: Material(
        color: colors.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: BorderSide(color: colors.outline, width: 3),
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ExcludeSemantics(
                  child: Image.asset(
                    state.imageAsset,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  state.title,
                  textAlign: TextAlign.center,
                  style: textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  state.detail,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
