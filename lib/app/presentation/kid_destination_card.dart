import 'package:flutter/material.dart';

enum KidDestinationCardVariant { compact, prominent, horizontal }

@immutable
class KidDestinationCardViewState {
  const KidDestinationCardViewState({
    required this.label,
    required this.detail,
    required this.icon,
    required this.semanticsLabel,
    this.backgroundAsset,
    this.showIcon = true,
    this.showDetail = true,
    this.showArrow = true,
  });

  final String label;
  final String detail;
  final IconData icon;
  final String semanticsLabel;
  final String? backgroundAsset;
  final bool showIcon;
  final bool showDetail;
  final bool showArrow;
}

class KidDestinationCard extends StatelessWidget {
  const KidDestinationCard({
    required this.state,
    required this.onPressed,
    this.variant = KidDestinationCardVariant.compact,
    super.key,
  });

  final KidDestinationCardViewState state;
  final VoidCallback onPressed;
  final KidDestinationCardVariant variant;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: state.semanticsLabel,
      excludeSemantics: true,
      child: switch (variant) {
        KidDestinationCardVariant.compact => _VerticalDestinationCard(
          state: state,
          onPressed: onPressed,
          prominent: false,
        ),
        KidDestinationCardVariant.prominent => _VerticalDestinationCard(
          state: state,
          onPressed: onPressed,
          prominent: true,
        ),
        KidDestinationCardVariant.horizontal => _HorizontalDestinationCard(
          state: state,
          onPressed: onPressed,
        ),
      },
    );
  }
}

class _VerticalDestinationCard extends StatelessWidget {
  const _VerticalDestinationCard({
    required this.state,
    required this.onPressed,
    required this.prominent,
  });

  final KidDestinationCardViewState state;
  final VoidCallback onPressed;
  final bool prominent;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: prominent ? colors.secondaryContainer : colors.primaryContainer,
      borderRadius: BorderRadius.circular(32),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onPressed,
        child: Stack(
          children: [
            _CardBackground(asset: state.backgroundAsset, opacity: 0.72),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: prominent ? 160 : 0),
              child: Padding(
                padding: EdgeInsets.all(prominent ? 24 : 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (state.showIcon) ...[
                        Icon(
                          state.icon,
                          size: prominent ? 64 : 48,
                          color: prominent ? null : colors.onPrimaryContainer,
                        ),
                        SizedBox(height: prominent ? 12 : 8),
                      ],
                      Text(
                        state.label,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: colors.onSurface,
                        ),
                      ),
                      if (state.showDetail)
                        Text(state.detail, textAlign: TextAlign.right),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HorizontalDestinationCard extends StatelessWidget {
  const _HorizontalDestinationCard({
    required this.state,
    required this.onPressed,
  });

  final KidDestinationCardViewState state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Stack(
          children: [
            _CardBackground(asset: state.backgroundAsset, opacity: 0.62),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (state.showIcon) ...[
                    Icon(state.icon, size: 40),
                    const SizedBox(width: 16),
                  ],
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: state.showIcon
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Text(
                          state.label,
                          textAlign: state.showIcon
                              ? TextAlign.left
                              : TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        if (state.showDetail) ...[
                          const SizedBox(height: 4),
                          Text(
                            state.detail,
                            textAlign: state.showIcon
                                ? TextAlign.left
                                : TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (state.showArrow) const Icon(Icons.arrow_forward_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardBackground extends StatelessWidget {
  const _CardBackground({required this.asset, required this.opacity});

  final String? asset;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    if (asset == null) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: ExcludeSemantics(
        child: Opacity(
          opacity: opacity,
          child: Image.asset(asset!, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
