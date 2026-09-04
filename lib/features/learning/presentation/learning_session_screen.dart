import 'package:flash_kids/app/presentation/kid_answer_control.dart';
import 'package:flash_kids/app/presentation/kid_feedback_panel.dart';
import 'package:flash_kids/app/presentation/kid_zone_scaffold.dart';
import 'package:flutter/material.dart';

enum LearningFeedback { none, encourage, readyForNext }

@immutable
class LearningSessionViewState {
  const LearningSessionViewState({
    required this.title,
    required this.instruction,
    required this.prompt,
    required this.visual,
    required this.answers,
    this.imageAsset,
    this.showAudio = false,
    this.showMicrophone = false,
    this.feedback = LearningFeedback.none,
  });

  final String title;
  final String instruction;
  final String prompt;
  final String visual;
  final String? imageAsset;
  final List<String> answers;
  final bool showAudio;
  final bool showMicrophone;
  final LearningFeedback feedback;
}

class LearningSessionScreen extends StatelessWidget {
  const LearningSessionScreen({
    required this.state,
    required this.onAnswer,
    required this.onNext,
    required this.onBack,
    required this.onHome,
    super.key,
  });

  final LearningSessionViewState state;
  final ValueChanged<String> onAnswer;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return KidZoneScaffold(
      title: state.title,
      onBack: onBack,
      onHome: onHome,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            children: [
              Semantics(
                label: 'Tiến độ buổi học',
                value: 'Đang học',
                child: const LinearProgressIndicator(value: 0.55),
              ),
              const SizedBox(height: 24),
              Text(
                state.instruction,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              MergeSemantics(
                child: Semantics(
                  label: '${state.visual}. ${state.prompt}',
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: colors.outline, width: 3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          if (state.imageAsset != null)
                            Image.asset(
                              state.imageAsset!,
                              height: 176,
                              semanticLabel: state.visual,
                            )
                          else
                            Text(
                              state.visual,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          const SizedBox(height: 16),
                          Text(
                            state.prompt,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (state.showAudio || state.showMicrophone) ...[
                            const SizedBox(height: 24),
                            Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              alignment: WrapAlignment.center,
                              children: [
                                if (state.showAudio)
                                  Semantics(
                                    label: 'Nghe nội dung mẫu',
                                    button: true,
                                    child: IconButton.filled(
                                      onPressed: () {},
                                      iconSize: 32,
                                      padding: const EdgeInsets.all(16),
                                      icon: const Icon(Icons.volume_up_rounded),
                                    ),
                                  ),
                                if (state.showMicrophone)
                                  Semantics(
                                    label: 'Nói theo nội dung mẫu',
                                    button: true,
                                    child: IconButton.filledTonal(
                                      onPressed: () {},
                                      iconSize: 32,
                                      padding: const EdgeInsets.all(16),
                                      icon: const Icon(Icons.mic_rounded),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (state.feedback != LearningFeedback.none)
                _FeedbackPanel(feedback: state.feedback),
              if (state.feedback == LearningFeedback.none) ...[
                Text(
                  'Chạm vào câu trả lời',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    for (final answer in state.answers)
                      KidAnswerControl(
                        state: KidAnswerControlViewState(
                          label: answer,
                          semanticsLabel: 'Chọn $answer',
                        ),
                        onPressed: () => onAnswer(answer),
                      ),
                  ],
                ),
              ] else ...[
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 64),
                  child: FilledButton.icon(
                    onPressed: onNext,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Tiếp tục'),
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

class _FeedbackPanel extends StatelessWidget {
  const _FeedbackPanel({required this.feedback});

  final LearningFeedback feedback;

  @override
  Widget build(BuildContext context) {
    final ready = feedback == LearningFeedback.readyForNext;
    return KidFeedbackPanel(
      state: KidFeedbackPanelViewState(
        message: ready ? 'Hay lắm!' : 'Mình thử lại nhé',
        semanticsLabel: ready ? 'Hay lắm, tiếp tục nhé' : 'Mình thử lại nhé',
        kind: ready ? KidFeedbackKind.success : KidFeedbackKind.encourage,
      ),
    );
  }
}
