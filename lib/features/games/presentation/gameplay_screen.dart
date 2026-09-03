import 'package:flash_kids/app/presentation/kid_answer_control.dart';
import 'package:flash_kids/app/presentation/kid_feedback_panel.dart';
import 'package:flash_kids/app/presentation/kid_zone_scaffold.dart';
import 'package:flutter/material.dart';

class GameplayScreen extends StatelessWidget {
  const GameplayScreen({
    required this.gameName,
    required this.hasFeedback,
    required this.onAnswer,
    required this.onNext,
    required this.onExit,
    required this.onHome,
    super.key,
  });

  final String gameName;
  final bool hasFeedback;
  final VoidCallback onAnswer;
  final VoidCallback onNext;
  final VoidCallback onExit;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return KidZoneScaffold(
      title: gameName,
      onBack: onExit,
      onHome: onHome,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const LinearProgressIndicator(value: 0.6),
              const SizedBox(height: 32),
              Text(
                'Tìm đáp án là 5',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    '🍎 🍎  +  🍎 🍎 🍎',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              if (!hasFeedback)
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final answer in const ['4', '5', '6'])
                      KidAnswerControl(
                        state: KidAnswerControlViewState(
                          label: answer,
                          semanticsLabel: 'Chọn đáp án $answer',
                        ),
                        onPressed: onAnswer,
                        variant: KidAnswerControlVariant.prominent,
                      ),
                  ],
                )
              else ...[
                const KidFeedbackPanel(
                  state: KidFeedbackPanelViewState(
                    message: 'Hay lắm!',
                    semanticsLabel: 'Hay lắm, bạn tìm được năm quả táo',
                    kind: KidFeedbackKind.success,
                  ),
                  variant: KidFeedbackPanelVariant.prominent,
                ),
                const SizedBox(height: 24),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 64),
                  child: FilledButton.icon(
                    onPressed: onNext,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Vòng tiếp theo'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
