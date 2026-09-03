import 'package:flutter/material.dart';

enum KidFeedbackKind { encourage, success }

enum KidFeedbackPanelVariant { compact, prominent }

@immutable
class KidFeedbackPanelViewState {
  const KidFeedbackPanelViewState({
    required this.message,
    required this.semanticsLabel,
    required this.kind,
  });

  final String message;
  final String semanticsLabel;
  final KidFeedbackKind kind;
}

class KidFeedbackPanel extends StatelessWidget {
  const KidFeedbackPanel({
    required this.state,
    this.variant = KidFeedbackPanelVariant.compact,
    super.key,
  });

  final KidFeedbackPanelViewState state;
  final KidFeedbackPanelVariant variant;

  @override
  Widget build(BuildContext context) {
    final success = state.kind == KidFeedbackKind.success;
    final prominent = variant == KidFeedbackPanelVariant.prominent;
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      liveRegion: true,
      label: state.semanticsLabel,
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: success ? colors.tertiaryContainer : colors.secondaryContainer,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: EdgeInsets.all(prominent ? 24 : 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                success ? Icons.star_rounded : Icons.replay_rounded,
                size: prominent ? 40 : null,
              ),
              SizedBox(width: prominent ? 12 : 8),
              Flexible(
                child: Text(
                  state.message,
                  style:
                      (prominent
                              ? Theme.of(context).textTheme.headlineSmall
                              : Theme.of(context).textTheme.titleLarge)
                          ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
