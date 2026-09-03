import 'package:flash_kids/app/presentation/kid_zone_scaffold.dart';
import 'package:flash_kids/app/presentation/large_action_button.dart';
import 'package:flutter/material.dart';

class GameDetailScreen extends StatelessWidget {
  const GameDetailScreen({
    required this.name,
    required this.skill,
    required this.icon,
    required this.onStart,
    required this.onBack,
    required this.onHome,
    super.key,
  });

  final String name;
  final String skill;
  final IconData icon;
  final VoidCallback onStart;
  final VoidCallback onBack;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return KidZoneScaffold(
      title: name,
      onBack: onBack,
      onHome: onHome,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.secondaryContainer,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(48),
                    child: Icon(icon, size: 120),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Nhìn hình và chọn thật nhanh',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16),
                Chip(
                  avatar: const Icon(Icons.school_rounded),
                  label: Text('Luyện tập: $skill'),
                ),
                const SizedBox(height: 32),
                LargeActionButton(
                  label: 'Bắt đầu chơi',
                  icon: Icons.play_arrow_rounded,
                  onPressed: onStart,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
