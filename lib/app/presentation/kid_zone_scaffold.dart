import 'package:flutter/material.dart';

class KidZoneScaffold extends StatelessWidget {
  const KidZoneScaffold({
    required this.title,
    required this.child,
    this.onBack,
    this.onHome,
    super.key,
  });

  final String title;
  final Widget child;
  final VoidCallback? onBack;
  final VoidCallback? onHome;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  if (onBack != null)
                    Semantics(
                      label: 'Quay lại màn hình trước',
                      button: true,
                      child: IconButton.filledTonal(
                        onPressed: onBack,
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                    )
                  else
                    const SizedBox(width: 48),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (onHome != null)
                    Semantics(
                      label: 'Về trang chủ',
                      button: true,
                      child: IconButton.filledTonal(
                        onPressed: onHome,
                        icon: const Icon(Icons.home_rounded),
                      ),
                    )
                  else
                    const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
