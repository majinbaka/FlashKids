import 'package:flash_kids/app/presentation/kid_feedback_panel.dart';
import 'package:flutter/material.dart';

class FeedbackPanelComponents extends StatelessWidget {
  const FeedbackPanelComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: const [
          KidFeedbackPanel(
            state: KidFeedbackPanelViewState(
              message: 'Mình thử lại nhé',
              semanticsLabel: 'Mình thử lại nhé',
              kind: KidFeedbackKind.encourage,
            ),
          ),
          SizedBox(height: 16),
          KidFeedbackPanel(
            state: KidFeedbackPanelViewState(
              message: 'Hay lắm!',
              semanticsLabel: 'Hay lắm, tiếp tục nhé',
              kind: KidFeedbackKind.success,
            ),
            variant: KidFeedbackPanelVariant.prominent,
          ),
        ],
      ),
    );
  }
}
