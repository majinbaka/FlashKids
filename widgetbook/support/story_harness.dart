import 'package:flutter/material.dart';

class StoryHarness extends StatelessWidget {
  const StoryHarness({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      child: SizedBox.expand(child: child),
    );
  }
}
