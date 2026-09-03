import 'package:flutter/material.dart';

enum KidAnswerControlVariant { standard, prominent }

@immutable
class KidAnswerControlViewState {
  const KidAnswerControlViewState({
    required this.label,
    required this.semanticsLabel,
  });

  final String label;
  final String semanticsLabel;
}

class KidAnswerControl extends StatelessWidget {
  const KidAnswerControl({
    required this.state,
    required this.onPressed,
    this.variant = KidAnswerControlVariant.standard,
    super.key,
  });

  final KidAnswerControlViewState state;
  final VoidCallback onPressed;
  final KidAnswerControlVariant variant;

  @override
  Widget build(BuildContext context) {
    final prominent = variant == KidAnswerControlVariant.prominent;
    final textStyle = prominent
        ? Theme.of(context).textTheme.headlineMedium
        : Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900);

    return Semantics(
      button: true,
      label: state.semanticsLabel,
      excludeSemantics: true,
      child: SizedBox(
        width: prominent ? 112 : 104,
        height: prominent ? 80 : 72,
        child: FilledButton.tonal(
          onPressed: onPressed,
          child: Text(state.label, style: textStyle),
        ),
      ),
    );
  }
}
