import 'package:flash_kids/app/presentation/kid_destination_card.dart';
import 'package:flutter/material.dart';

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
    required this.onCollection,
    required this.onParentArea,
    super.key,
  });

  final List<LearningModuleSummary> modules;
  final ValueChanged<LearningModuleSummary> onModuleSelected;
  final VoidCallback onGames;
  final VoidCallback onCollection;
  final VoidCallback onParentArea;

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
                        onModuleSelected: onModuleSelected,
                        onGames: onGames,
                        onCollection: onCollection,
                        onParentArea: onParentArea,
                      )
                    : _PortraitHomeContent(
                        modules: modules,
                        onModuleSelected: onModuleSelected,
                        onGames: onGames,
                        onCollection: onCollection,
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
    required this.onModuleSelected,
    required this.onGames,
    required this.onCollection,
    required this.onParentArea,
  });

  final List<LearningModuleSummary> modules;
  final ValueChanged<LearningModuleSummary> onModuleSelected;
  final VoidCallback onGames;
  final VoidCallback onCollection;
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
                        'Chào bạn nhỏ',
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
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text(
              'HỌC',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colors.tertiary,
                fontWeight: FontWeight.bold,
              ),
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
                  ],
                );
              },
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              'CHƠI',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colors.tertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          sliver: SliverToBoxAdapter(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: 240,
                  child: KidDestinationCard(
                    state: const KidDestinationCardViewState(
                      label: 'Mini game',
                      detail: 'Chọn trò chơi',
                      icon: Icons.sports_esports_rounded,
                      semanticsLabel: 'Mini game. Chọn trò chơi',
                    ),
                    onPressed: onGames,
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: KidDestinationCard(
                    state: const KidDestinationCardViewState(
                      label: 'Bộ sưu tập',
                      detail: 'Xem sticker',
                      icon: Icons.auto_awesome_rounded,
                      semanticsLabel: 'Bộ sưu tập. Xem sticker',
                    ),
                    onPressed: onCollection,
                  ),
                ),
              ],
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
    required this.onModuleSelected,
    required this.onGames,
    required this.onCollection,
    required this.onParentArea,
  });

  final List<LearningModuleSummary> modules;
  final ValueChanged<LearningModuleSummary> onModuleSelected;
  final VoidCallback onGames;
  final VoidCallback onCollection;
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
                            'Chào bạn nhỏ',
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
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'HỌC',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: colors.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Row(
                    children: [
                      for (var index = 0; index < modules.length; index++) ...[
                        Expanded(
                          child: KidDestinationCard(
                            state: KidDestinationCardViewState(
                              label: modules[index].label,
                              detail: modules[index].detail,
                              icon: modules[index].icon,
                              backgroundAsset: modules[index].backgroundAsset,
                              semanticsLabel: modules[index].label,
                              showIcon: false,
                              showDetail: false,
                            ),
                            onPressed: () => onModuleSelected(modules[index]),
                            variant: KidDestinationCardVariant.prominent,
                          ),
                        ),
                        if (index < modules.length - 1)
                          const SizedBox(width: 16),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'CHƠI',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: colors.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: KidDestinationCard(
                    state: const KidDestinationCardViewState(
                      label: 'Mini game',
                      detail: 'Chọn trò chơi',
                      icon: Icons.sports_esports_rounded,
                      semanticsLabel: 'Mini game. Chọn trò chơi',
                      showIcon: false,
                      showDetail: false,
                    ),
                    onPressed: onGames,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: KidDestinationCard(
                    state: const KidDestinationCardViewState(
                      label: 'Bộ sưu tập',
                      detail: 'Xem sticker',
                      icon: Icons.auto_awesome_rounded,
                      semanticsLabel: 'Bộ sưu tập. Xem sticker',
                      showIcon: false,
                      showDetail: false,
                    ),
                    onPressed: onCollection,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
