import 'package:flash_kids/app/presentation/kid_destination_card.dart';
import 'package:flash_kids/app/presentation/kid_zone_scaffold.dart';
import 'package:flutter/material.dart';

@immutable
class LearningActivitySummary {
  const LearningActivitySummary({
    required this.id,
    required this.label,
    required this.description,
    required this.icon,
    required this.backgroundAsset,
  });

  final String id;
  final String label;
  final String description;
  final IconData icon;
  final String backgroundAsset;
}

class ModuleOverviewScreen extends StatelessWidget {
  const ModuleOverviewScreen({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.activities,
    required this.onActivitySelected,
    required this.onBack,
    required this.onHome,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<LearningActivitySummary> activities;
  final ValueChanged<LearningActivitySummary> onActivitySelected;
  final VoidCallback onBack;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return KidZoneScaffold(
      title: title,
      onBack: onBack,
      onHome: onHome,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.tertiaryContainer,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: colors.outline, width: 3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Icon(icon, size: 64, color: colors.onTertiaryContainer),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Text(
                          subtitle,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Chọn cách học',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              for (final activity in activities) ...[
                KidDestinationCard(
                  state: KidDestinationCardViewState(
                    label: activity.label,
                    detail: activity.description,
                    icon: activity.icon,
                    backgroundAsset: activity.backgroundAsset,
                    semanticsLabel:
                        '${activity.label}. ${activity.description}',
                    showIcon: false,
                    showDetail: false,
                    showArrow: false,
                  ),
                  onPressed: () => onActivitySelected(activity),
                  variant: KidDestinationCardVariant.horizontal,
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
