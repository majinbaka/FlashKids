import 'package:flash_kids/features/learning/presentation/learning_session_screen.dart';
import 'package:flash_kids/app/presentation/flash_kids_theme.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'app_prototype/full_application_flow.dart';
import 'addons/orientation_viewport_addon.dart';
import 'components/action_components.dart';
import 'components/answer_control_components.dart';
import 'components/destination_card_components.dart';
import 'components/feedback_panel_components.dart';
import 'screens/representative_screens.dart';
import 'support/story_harness.dart';

class FlashKidsWidgetbook extends StatelessWidget {
  const FlashKidsWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = flashKidsTheme();
    return Widgetbook.material(
      directories: [
        WidgetbookCategory(
          name: 'Components',
          children: [
            WidgetbookComponent(
              name: 'Large Action Button',
              useCases: [
                WidgetbookUseCase(
                  name: 'Primary, Secondary, Disabled',
                  builder: (_) => const StoryHarness(child: ActionComponents()),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Destination Card',
              useCases: [
                WidgetbookUseCase(
                  name: 'Compact, Prominent, Horizontal',
                  builder: (_) =>
                      const StoryHarness(child: DestinationCardComponents()),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Answer Control',
              useCases: [
                WidgetbookUseCase(
                  name: 'Standard, Prominent',
                  builder: (_) =>
                      const StoryHarness(child: AnswerControlComponents()),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Feedback Panel',
              useCases: [
                WidgetbookUseCase(
                  name: 'Encourage, Success',
                  builder: (_) =>
                      const StoryHarness(child: FeedbackPanelComponents()),
                ),
              ],
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Screens',
          children: [
            WidgetbookComponent(
              name: 'Home',
              useCases: [
                WidgetbookUseCase(
                  name: 'kid.home.returning',
                  builder: (_) => const StoryHarness(child: HomeScreenStory()),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Learning Session',
              useCases: [
                WidgetbookUseCase(
                  name: 'learning.session.observe',
                  builder: (_) => const StoryHarness(
                    child: LearningSessionStory(
                      feedback: LearningFeedback.none,
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'learning.session.success',
                  builder: (_) => const StoryHarness(
                    child: LearningSessionStory(
                      feedback: LearningFeedback.readyForNext,
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Game Hub',
              useCases: [
                WidgetbookUseCase(
                  name: 'games.hub.empty',
                  builder: (_) =>
                      const StoryHarness(child: EmptyGameHubStory()),
                ),
              ],
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'App Prototype',
          children: [
            WidgetbookComponent(
              name: 'Full Application Flow',
              useCases: [
                WidgetbookUseCase(
                  name: 'Full Application Flow',
                  builder: (_) =>
                      const StoryHarness(child: FullApplicationFlow()),
                ),
              ],
            ),
          ],
        ),
      ],
      addons: [
        MaterialThemeAddon(
          themes: [WidgetbookTheme(name: 'FlashKids Light', data: theme)],
        ),
        OrientationViewportAddon([
          AndroidViewports.samsungGalaxyA50,
          AndroidViewports.smallTablet,
        ]),
        TextScaleAddon(min: 1, max: 2, divisions: 4),
      ],
    );
  }
}
