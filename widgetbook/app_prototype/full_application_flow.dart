import 'package:flash_kids/features/collection/presentation/collection_screen.dart';
import 'package:flash_kids/features/games/presentation/game_detail_screen.dart';
import 'package:flash_kids/features/games/presentation/game_hub_screen.dart';
import 'package:flash_kids/features/games/presentation/game_result_screen.dart';
import 'package:flash_kids/features/games/presentation/gameplay_screen.dart';
import 'package:flash_kids/features/home/presentation/child_home_screen.dart';
import 'package:flash_kids/features/home/presentation/launch_screen.dart';
import 'package:flash_kids/features/learning/presentation/learning_session_screen.dart';
import 'package:flash_kids/features/learning/presentation/lesson_complete_screen.dart';
import 'package:flash_kids/features/learning/presentation/module_overview_screen.dart';
import 'package:flash_kids/features/parent/presentation/child_profile_screen.dart';
import 'package:flash_kids/features/parent/presentation/learning_settings_screen.dart';
import 'package:flash_kids/features/parent/presentation/parent_gate_screen.dart';
import 'package:flash_kids/features/parent/presentation/parent_overview_screen.dart';
import 'package:flash_kids/features/parent/presentation/parent_progress_screen.dart';
import 'package:flutter/material.dart';

import 'prototype_data.dart';

enum PrototypePage {
  launch,
  home,
  module,
  learning,
  lessonComplete,
  gameHub,
  gameDetail,
  gameplay,
  gameResult,
  collection,
  parentGate,
  parentOverview,
  parentProgress,
  parentSettings,
  childProfile,
}

class FullApplicationFlow extends StatefulWidget {
  const FullApplicationFlow({super.key});

  @override
  State<FullApplicationFlow> createState() => _FullApplicationFlowState();
}

class _FullApplicationFlowState extends State<FullApplicationFlow> {
  PrototypePage _page = PrototypePage.launch;
  LearningModuleSummary _module = prototypeModules.first;
  LearningActivitySummary _activity = activitiesFor(
    prototypeModules.first.id,
  ).first;
  GameSummary _game = prototypeGames.first;
  LearningFeedback _learningFeedback = LearningFeedback.none;
  bool _gameFeedback = false;

  void _go(PrototypePage page) => setState(() => _page = page);

  void _goHome() {
    setState(() {
      _page = PrototypePage.home;
      _learningFeedback = LearningFeedback.none;
      _gameFeedback = false;
    });
  }

  void _openModule(LearningModuleSummary module) {
    setState(() {
      _module = module;
      _activity = activitiesFor(module.id).first;
      _learningFeedback = LearningFeedback.none;
      _page = PrototypePage.module;
    });
  }

  void _openActivity(LearningActivitySummary activity) {
    setState(() {
      _activity = activity;
      _learningFeedback = LearningFeedback.none;
      _page = PrototypePage.learning;
    });
  }

  void _openGame(GameSummary game) {
    setState(() {
      _game = game;
      _gameFeedback = false;
      _page = PrototypePage.gameDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return switch (_page) {
      PrototypePage.launch => LaunchScreen(
        onContinue: () => _go(PrototypePage.home),
      ),
      PrototypePage.home => ChildHomeScreen(
        modules: prototypeModules,
        onModuleSelected: _openModule,
        onGames: () => _go(PrototypePage.gameHub),
        onCollection: () => _go(PrototypePage.collection),
        onParentArea: () => _go(PrototypePage.parentGate),
      ),
      PrototypePage.module => ModuleOverviewScreen(
        title: _module.label,
        subtitle: _module.detail,
        icon: _module.icon,
        activities: activitiesFor(_module.id),
        onActivitySelected: _openActivity,
        onBack: _goHome,
        onHome: _goHome,
      ),
      PrototypePage.learning => LearningSessionScreen(
        state: sessionFor(_module, _activity, _learningFeedback),
        onAnswer: (_) =>
            setState(() => _learningFeedback = LearningFeedback.readyForNext),
        onNext: () => _go(PrototypePage.lessonComplete),
        onBack: () => _go(PrototypePage.module),
        onHome: _goHome,
      ),
      PrototypePage.lessonComplete => LessonCompleteScreen(
        moduleName: _activity.label,
        onContinue: () => _go(PrototypePage.module),
        onHome: _goHome,
      ),
      PrototypePage.gameHub => GameHubScreen(
        games: prototypeGames,
        onGameSelected: _openGame,
        onBack: _goHome,
        onHome: _goHome,
      ),
      PrototypePage.gameDetail => GameDetailScreen(
        name: _game.name,
        skill: _game.skill,
        icon: _game.icon,
        onStart: () => _go(PrototypePage.gameplay),
        onBack: () => _go(PrototypePage.gameHub),
        onHome: _goHome,
      ),
      PrototypePage.gameplay => GameplayScreen(
        gameName: _game.name,
        hasFeedback: _gameFeedback,
        onAnswer: () => setState(() => _gameFeedback = true),
        onNext: () => _go(PrototypePage.gameResult),
        onExit: () => _go(PrototypePage.gameDetail),
        onHome: _goHome,
      ),
      PrototypePage.gameResult => GameResultScreen(
        gameName: _game.name,
        onReplay: () => setState(() {
          _gameFeedback = false;
          _page = PrototypePage.gameplay;
        }),
        onGameHub: () => _go(PrototypePage.gameHub),
        onHome: _goHome,
      ),
      PrototypePage.collection => CollectionScreen(
        onBack: _goHome,
        onHome: _goHome,
      ),
      PrototypePage.parentGate => ParentGateScreen(
        onVerified: () => _go(PrototypePage.parentOverview),
        onCancel: _goHome,
      ),
      PrototypePage.parentOverview => ParentOverviewScreen(
        onProgress: () => _go(PrototypePage.parentProgress),
        onSettings: () => _go(PrototypePage.parentSettings),
        onProfile: () => _go(PrototypePage.childProfile),
        onExit: _goHome,
      ),
      PrototypePage.parentProgress => ParentProgressScreen(
        onBack: () => _go(PrototypePage.parentOverview),
      ),
      PrototypePage.parentSettings => LearningSettingsScreen(
        onBack: () => _go(PrototypePage.parentOverview),
      ),
      PrototypePage.childProfile => ChildProfileScreen(
        onBack: () => _go(PrototypePage.parentOverview),
      ),
    };
  }
}
