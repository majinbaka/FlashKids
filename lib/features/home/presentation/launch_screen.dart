import 'package:flash_kids/app/presentation/large_action_button.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({required this.onContinue, super.key});

  final VoidCallback onContinue;

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
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                ExcludeSemantics(
                  child: Image.asset(
                    'assets/images/mascots/mascot-idle.png',
                    height: 240,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'FlashKids',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nhìn • Nghe • Chơi • Học',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 32),
                LargeActionButton(
                  label: 'Bắt đầu',
                  icon: Icons.play_arrow_rounded,
                  onPressed: onContinue,
                ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
