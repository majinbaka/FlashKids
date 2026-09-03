import 'package:flash_kids/app/presentation/kid_zone_scaffold.dart';
import 'package:flash_kids/app/presentation/large_action_button.dart';
import 'package:flutter/material.dart';

class LessonCompleteScreen extends StatelessWidget {
  const LessonCompleteScreen({
    required this.moduleName,
    required this.onContinue,
    required this.onHome,
    super.key,
  });

  final String moduleName;
  final VoidCallback onContinue;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return KidZoneScaffold(
      title: 'Hoàn thành',
      onHome: onHome,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: [
                ExcludeSemantics(
                  child: Image.asset(
                    'assets/images/mascots/mascot-cheer.png',
                    height: 220,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Bạn đã luyện tập $moduleName',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  label: 'Nhận được một sticker ngôi sao',
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.tertiaryContainer,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(24),
                      child: Icon(Icons.stars_rounded, size: 88),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    LargeActionButton(
                      label: 'Học tiếp',
                      icon: Icons.play_arrow_rounded,
                      onPressed: onContinue,
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
