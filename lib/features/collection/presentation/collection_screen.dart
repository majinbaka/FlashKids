import 'package:flash_kids/app/presentation/kid_zone_scaffold.dart';
import 'package:flutter/material.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({
    required this.onBack,
    required this.onHome,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return KidZoneScaffold(
      title: 'Bộ sưu tập',
      onBack: onBack,
      onHome: onHome,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'Những điều mình đã học',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _MasteryCard(
                    label: 'Chữ cái',
                    detail: 'Đang học',
                    icon: Icons.abc_rounded,
                    stars: 2,
                    background: colors.primaryContainer,
                  ),
                  _MasteryCard(
                    label: 'Từ mới',
                    detail: 'Mới bắt đầu',
                    icon: Icons.image_rounded,
                    stars: 1,
                    background: colors.secondaryContainer,
                  ),
                  _MasteryCard(
                    label: 'Phép cộng',
                    detail: 'Đã làm quen',
                    icon: Icons.calculate_rounded,
                    stars: 2,
                    background: colors.tertiaryContainer,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Sticker của mình',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: colors.outline, width: 3),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(24),
                  child: Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: [
                      _Sticker(icon: Icons.pets_rounded, label: 'Bạn của thú'),
                      _Sticker(icon: Icons.star_rounded, label: 'Ngôi sao học'),
                      _Sticker(
                        icon: Icons.rocket_launch_rounded,
                        label: 'Cất cánh',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MasteryCard extends StatelessWidget {
  const _MasteryCard({
    required this.label,
    required this.detail,
    required this.icon,
    required this.stars,
    required this.background,
  });

  final String label;
  final String detail;
  final IconData icon;
  final int stars;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label. $detail. $stars sao',
      excludeSemantics: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 208, maxWidth: 240),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 56),
                const SizedBox(height: 12),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(detail, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    stars,
                    (_) => const Icon(Icons.star_rounded, size: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Sticker extends StatelessWidget {
  const _Sticker({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Sticker $label',
      excludeSemantics: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
