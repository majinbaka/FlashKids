import 'package:flash_kids/app/presentation/kid_zone_scaffold.dart';
import 'package:flash_kids/app/presentation/large_action_button.dart';
import 'package:flutter/material.dart';

class GameResultScreen extends StatelessWidget {
  const GameResultScreen({
    required this.gameName,
    required this.onReplay,
    required this.onGameHub,
    required this.onHome,
    super.key,
  });

  final String gameName;
  final VoidCallback onReplay;
  final VoidCallback onGameHub;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    return KidZoneScaffold(
      title: 'Trò chơi hoàn thành',
      onHome: onHome,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              children: [
                ExcludeSemantics(
                  child: Image.asset(
                    'assets/images/mascots/mascot-cheer.png',
                    height: 220,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Bạn đã chơi $gameName',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    LargeActionButton(
                      label: 'Chơi lại',
                      icon: Icons.replay_rounded,
                      onPressed: onReplay,
                    ),
                    LargeActionButton(
                      label: 'Chọn trò khác',
                      icon: Icons.grid_view_rounded,
                      onPressed: onGameHub,
                      filled: false,
                    ),
                    LargeActionButton(
                      label: 'Về trang chủ',
                      icon: Icons.home_rounded,
                      onPressed: onHome,
                      filled: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
