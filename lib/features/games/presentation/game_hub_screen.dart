import 'package:flash_kids/app/presentation/kid_destination_card.dart';
import 'package:flash_kids/app/presentation/kid_zone_scaffold.dart';
import 'package:flutter/material.dart';

@immutable
class GameSummary {
  const GameSummary({
    required this.name,
    required this.skill,
    required this.icon,
  });

  final String name;
  final String skill;
  final IconData icon;
}

class GameHubScreen extends StatelessWidget {
  const GameHubScreen({
    required this.games,
    required this.onGameSelected,
    required this.onBack,
    required this.onHome,
    super.key,
  });

  final List<GameSummary> games;
  final ValueChanged<GameSummary> onGameSelected;
  final VoidCallback onBack;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    return KidZoneScaffold(
      title: 'Mini game',
      onBack: onBack,
      onHome: onHome,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: games.isEmpty
              ? const _EmptyGameLibrary()
              : ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemCount: games.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final game = games[index];
                    return KidDestinationCard(
                      state: KidDestinationCardViewState(
                        label: game.name,
                        detail: game.skill,
                        icon: game.icon,
                        semanticsLabel: '${game.name}. Kỹ năng ${game.skill}',
                      ),
                      onPressed: () => onGameSelected(game),
                      variant: KidDestinationCardVariant.prominent,
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _EmptyGameLibrary extends StatelessWidget {
  const _EmptyGameLibrary();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ExcludeSemantics(
            child: Image.asset(
              'assets/images/states/state-empty.png',
              height: 220,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Trò chơi đang chuẩn bị',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          const Text('Mình quay lại sau nhé', textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
