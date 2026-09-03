import 'package:flash_kids/features/games/presentation/game_hub_screen.dart';
import 'package:flash_kids/features/home/presentation/child_home_screen.dart';
import 'package:flash_kids/features/learning/presentation/learning_session_screen.dart';
import 'package:flutter/material.dart';

import '../app_prototype/prototype_data.dart';

class HomeScreenStory extends StatelessWidget {
  const HomeScreenStory({super.key});

  @override
  Widget build(BuildContext context) {
    return ChildHomeScreen(
      modules: prototypeModules,
      onModuleSelected: (_) {},
      onGames: () {},
      onCollection: () {},
      onParentArea: () {},
    );
  }
}

class LearningSessionStory extends StatelessWidget {
  const LearningSessionStory({required this.feedback, super.key});

  final LearningFeedback feedback;

  @override
  Widget build(BuildContext context) {
    return LearningSessionScreen(
      state: sessionFor(
        prototypeModules.first,
        activitiesFor(prototypeModules.first.id).first,
        feedback,
      ),
      onAnswer: (_) {},
      onNext: () {},
      onBack: () {},
      onHome: () {},
    );
  }
}

class EmptyGameHubStory extends StatelessWidget {
  const EmptyGameHubStory({super.key});

  @override
  Widget build(BuildContext context) {
    return GameHubScreen(
      games: const [],
      onGameSelected: (_) {},
      onBack: () {},
      onHome: () {},
    );
  }
}
