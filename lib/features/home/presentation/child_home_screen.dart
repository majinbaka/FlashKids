import 'package:flash_kids/app/presentation/kid_destination_card.dart';
import 'package:flash_kids/features/home/presentation/recommended_lesson_list.dart';
import 'package:flutter/material.dart';

const _gamesBackgroundAsset =
    'assets/images/subjects/games-subject-background.png';

@immutable
class LearningModuleSummary {
  const LearningModuleSummary({
    required this.id,
    required this.label,
    required this.icon,
    required this.detail,
    required this.backgroundAsset,
  });

  final String id;
  final String label;
  final IconData icon;
  final String detail;
  final String backgroundAsset;
}

class ChildHomeScreen extends StatelessWidget {
  const ChildHomeScreen({
    required this.modules,
    required this.onModuleSelected,
    required this.onGames,
    required this.onParentArea,
    this.childName = 'bạn nhỏ',
    this.recommendations = const [],
    this.onRecommendationSelected,
    super.key,
  });

  final List<LearningModuleSummary> modules;
  final ValueChanged<LearningModuleSummary> onModuleSelected;
  final VoidCallback onGames;
  final VoidCallback onParentArea;
  final String childName;
  final List<LessonRecommendation> recommendations;
  final ValueChanged<LessonRecommendation>? onRecommendationSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: DefaultTextStyle.merge(
        style: TextStyle(color: colors.onInverseSurface),
        child: IconTheme.merge(
          data: IconThemeData(color: colors.onInverseSurface),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape =
                    constraints.maxWidth >= constraints.maxHeight * 1.6;
                return isLandscape
                    ? _LandscapeHomeContent(
                        modules: modules,
                        childName: childName,
                        onModuleSelected: onModuleSelected,
                        onGames: onGames,
                        onParentArea: onParentArea,
                      )
                    : _PortraitHomeContent(
                        modules: modules,
                        childName: childName,
                        recommendations: recommendations,
                        onRecommendationSelected: onRecommendationSelected,
                        onModuleSelected: onModuleSelected,
                        onGames: onGames,
                        onParentArea: onParentArea,
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PortraitHomeContent extends StatelessWidget {
  const _PortraitHomeContent({
    required this.modules,
    required this.childName,
    required this.recommendations,
    required this.onRecommendationSelected,
    required this.onModuleSelected,
    required this.onGames,
    required this.onParentArea,
  });

  final List<LearningModuleSummary> modules;
  final String childName;
  final List<LessonRecommendation> recommendations;
  final ValueChanged<LessonRecommendation>? onRecommendationSelected;
  final ValueChanged<LearningModuleSummary> onModuleSelected;
  final VoidCallback onGames;
  final VoidCallback onParentArea;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          sliver: SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chào $childName',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Hôm nay mình học gì?',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                ExcludeSemantics(
                  child: Image.asset(
                    'assets/images/mascots/mascot-idle.png',
                    width: 88,
                    height: 88,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (onRecommendationSelected != null && recommendations.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            sliver: SliverToBoxAdapter(
              child: RecommendedLessonList(
                recommendations: recommendations,
                onSelected: onRecommendationSelected!,
              ),
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = constraints.maxWidth >= 520
                    ? (constraints.maxWidth - 16) / 2
                    : constraints.maxWidth;
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    for (final module in modules)
                      SizedBox(
                        width: cardWidth,
                        child: KidDestinationCard(
                          state: KidDestinationCardViewState(
                            label: module.label,
                            detail: module.detail,
                            icon: module.icon,
                            backgroundAsset: module.backgroundAsset,
                            semanticsLabel: module.label,
                            showIcon: false,
                            showDetail: false,
                          ),
                          onPressed: () => onModuleSelected(module),
                          variant: KidDestinationCardVariant.prominent,
                        ),
                      ),
                    SizedBox(
                      width: cardWidth,
                      child: KidDestinationCard(
                        state: const KidDestinationCardViewState(
                          label: 'Mini game',
                          detail: 'Chọn trò chơi',
                          icon: Icons.sports_esports_rounded,
                          backgroundAsset: _gamesBackgroundAsset,
                          semanticsLabel: 'Mini game',
                          showIcon: false,
                          showDetail: false,
                        ),
                        onPressed: onGames,
                        variant: KidDestinationCardVariant.prominent,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          sliver: SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerRight,
              child: Semantics(
                label: 'Mở cổng dành cho phụ huynh',
                button: true,
                child: TextButton.icon(
                  onPressed: onParentArea,
                  style: TextButton.styleFrom(
                    foregroundColor: colors.onInverseSurface,
                  ),
                  icon: const Icon(Icons.family_restroom_rounded),
                  label: const Text('Phụ huynh'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LandscapeHomeContent extends StatelessWidget {
  const _LandscapeHomeContent({
    required this.modules,
    required this.childName,
    required this.onModuleSelected,
    required this.onGames,
    required this.onParentArea,
  });

  final List<LearningModuleSummary> modules;
  final String childName;
  final ValueChanged<LearningModuleSummary> onModuleSelected;
  final VoidCallback onGames;
  final VoidCallback onParentArea;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chào $childName',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Hôm nay mình học gì?',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    ExcludeSemantics(
                      child: Image.asset(
                        'assets/images/mascots/mascot-idle.png',
                        width: 64,
                        height: 64,
                      ),
                    ),
                    Semantics(
                      label: 'Mở cổng dành cho phụ huynh',
                      button: true,
                      child: TextButton.icon(
                        onPressed: onParentArea,
                        style: TextButton.styleFrom(
                          foregroundColor: colors.onInverseSurface,
                        ),
                        icon: const Icon(Icons.family_restroom_rounded),
                        label: const Text('Phụ huynh'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Row(
                    children: [
                      for (
                        var index = 0;
                        index < modules.length + 1;
                        index++
                      ) ...[
                        Expanded(
                          child: KidDestinationCard(
                            state: index < modules.length
                                ? KidDestinationCardViewState(
                                    label: modules[index].label,
                                    detail: modules[index].detail,
                                    icon: modules[index].icon,
                                    backgroundAsset:
                                        modules[index].backgroundAsset,
                                    semanticsLabel: modules[index].label,
                                    showIcon: false,
                                    showDetail: false,
                                  )
                                : const KidDestinationCardViewState(
                                    label: 'Mini game',
                                    detail: 'Chọn trò chơi',
                                    icon: Icons.sports_esports_rounded,
                                    backgroundAsset: _gamesBackgroundAsset,
                                    semanticsLabel: 'Mini game',
                                    showIcon: false,
                                    showDetail: false,
                                  ),
                            onPressed: index < modules.length
                                ? () => onModuleSelected(modules[index])
                                : onGames,
                            variant: KidDestinationCardVariant.prominent,
                          ),
                        ),
                        if (index < modules.length) const SizedBox(width: 16),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
