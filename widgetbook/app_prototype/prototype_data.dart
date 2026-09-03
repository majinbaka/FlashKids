import 'package:flash_kids/features/games/presentation/game_hub_screen.dart';
import 'package:flash_kids/features/home/presentation/child_home_screen.dart';
import 'package:flash_kids/features/learning/presentation/learning_session_screen.dart';
import 'package:flash_kids/features/learning/presentation/module_overview_screen.dart';
import 'package:flutter/material.dart';

const vietnameseBackground =
    'assets/images/subjects/vietnamese-subject-background.png';
const englishBackground =
    'assets/images/subjects/english-subject-background.png';
const mathBackground = 'assets/images/subjects/math-subject-background.png';

const prototypeModules = <LearningModuleSummary>[
  LearningModuleSummary(
    id: 'vietnamese',
    label: 'Tiếng Việt',
    icon: Icons.menu_book_rounded,
    detail: 'Chữ cái, đánh vần',
    backgroundAsset: vietnameseBackground,
  ),
  LearningModuleSummary(
    id: 'english',
    label: 'Tiếng Anh',
    icon: Icons.translate_rounded,
    detail: 'Từ vựng, phát âm',
    backgroundAsset: englishBackground,
  ),
  LearningModuleSummary(
    id: 'math',
    label: 'Toán',
    icon: Icons.calculate_rounded,
    detail: 'Cộng, trừ',
    backgroundAsset: mathBackground,
  ),
];

const prototypeGames = <GameSummary>[
  GameSummary(
    name: 'Nghe và chọn',
    skill: 'Từ vựng',
    icon: Icons.hearing_rounded,
  ),
  GameSummary(
    name: 'Ghép đôi',
    skill: 'Trí nhớ',
    icon: Icons.grid_view_rounded,
  ),
  GameSummary(name: 'Xếp từ', skill: 'Đánh vần', icon: Icons.extension_rounded),
  GameSummary(
    name: 'Toán nhanh',
    skill: 'Phép cộng',
    icon: Icons.calculate_rounded,
  ),
];

List<LearningActivitySummary> activitiesFor(String moduleId) {
  return switch (moduleId) {
    'vietnamese' => const [
      LearningActivitySummary(
        id: 'vietnamese-alphabet',
        label: 'Chữ cái',
        description: 'Nhận biết chữ cái',
        icon: Icons.abc_rounded,
        backgroundAsset: vietnameseBackground,
      ),
      LearningActivitySummary(
        id: 'vietnamese-spelling',
        label: 'Đánh vần',
        description: 'Ghép các tiếng đơn giản',
        icon: Icons.extension_rounded,
        backgroundAsset: vietnameseBackground,
      ),
      LearningActivitySummary(
        id: 'vietnamese-pronunciation',
        label: 'Phát âm',
        description: 'Nghe mẫu rồi nói theo',
        icon: Icons.record_voice_over_rounded,
        backgroundAsset: vietnameseBackground,
      ),
      LearningActivitySummary(
        id: 'vietnamese-games',
        label: 'Mini games',
        description: 'Chơi và ôn Tiếng Việt',
        icon: Icons.sports_esports_rounded,
        backgroundAsset: vietnameseBackground,
      ),
    ],
    'english' => const [
      LearningActivitySummary(
        id: 'english-vocabulary',
        label: 'Từ vựng',
        description: 'Học từ bằng hình ảnh',
        icon: Icons.image_rounded,
        backgroundAsset: englishBackground,
      ),
      LearningActivitySummary(
        id: 'english-pronunciation',
        label: 'Phát âm',
        description: 'Nghe và nói theo',
        icon: Icons.mic_rounded,
        backgroundAsset: englishBackground,
      ),
      LearningActivitySummary(
        id: 'english-games',
        label: 'Mini games',
        description: 'Chơi và ôn Tiếng Anh',
        icon: Icons.sports_esports_rounded,
        backgroundAsset: englishBackground,
      ),
    ],
    'math' => const [
      LearningActivitySummary(
        id: 'math-addition',
        label: 'Cộng',
        description: 'Gộp các nhóm đồ vật',
        icon: Icons.add_circle_rounded,
        backgroundAsset: mathBackground,
      ),
      LearningActivitySummary(
        id: 'math-subtraction',
        label: 'Trừ',
        description: 'Xem còn lại bao nhiêu',
        icon: Icons.remove_circle_rounded,
        backgroundAsset: mathBackground,
      ),
      LearningActivitySummary(
        id: 'math-games',
        label: 'Mini games',
        description: 'Chơi và ôn Toán',
        icon: Icons.sports_esports_rounded,
        backgroundAsset: mathBackground,
      ),
    ],
    _ => const [],
  };
}

LearningSessionViewState sessionFor(
  LearningModuleSummary module,
  LearningActivitySummary activity,
  LearningFeedback feedback,
) {
  return switch (activity.id) {
    'vietnamese-alphabet' => LearningSessionViewState(
      title: activity.label,
      instruction: 'Chọn chữ A',
      prompt: 'A như An',
      visual: 'A a',
      answers: const ['A', 'B', 'C'],
      showAudio: true,
      feedback: feedback,
    ),
    'vietnamese-spelling' => LearningSessionViewState(
      title: activity.label,
      instruction: 'Điền chữ còn thiếu',
      prompt: 'C _ Á',
      visual: 'Một quả cá',
      answers: const ['A', 'E', 'O'],
      showAudio: true,
      feedback: feedback,
    ),
    'vietnamese-pronunciation' => LearningSessionViewState(
      title: activity.label,
      instruction: 'Nghe rồi nói theo',
      prompt: 'Bé',
      visual: 'Một bạn nhỏ',
      answers: const ['Đã nói', 'Nghe lại'],
      showAudio: true,
      showMicrophone: true,
      feedback: feedback,
    ),
    'english-vocabulary' => LearningSessionViewState(
      title: activity.label,
      instruction: 'Tìm từ đúng',
      prompt: 'Cat',
      visual: 'Một chú mèo',
      imageAsset: 'assets/images/cards/card-animal-cat.png',
      answers: const ['Cat', 'Dog', 'Bee'],
      showAudio: true,
      feedback: feedback,
    ),
    'english-pronunciation' => LearningSessionViewState(
      title: activity.label,
      instruction: 'Nghe rồi nói theo',
      prompt: 'Cat',
      visual: 'Một chú mèo',
      imageAsset: 'assets/images/cards/card-animal-cat.png',
      answers: const ['Đã nói', 'Nghe lại'],
      showAudio: true,
      showMicrophone: true,
      feedback: feedback,
    ),
    'math-addition' => LearningSessionViewState(
      title: activity.label,
      instruction: 'Có tất cả bao nhiêu?',
      prompt: '2 + 3 = ?',
      visual: '🍎 🍎  +  🍎 🍎 🍎',
      answers: const ['4', '5', '6'],
      feedback: feedback,
    ),
    'math-subtraction' => LearningSessionViewState(
      title: activity.label,
      instruction: 'Còn lại bao nhiêu?',
      prompt: '5 − 2 = ?',
      visual: '🍎 🍎 🍎 🍎 🍎  −  🍎 🍎',
      answers: const ['2', '3', '4'],
      feedback: feedback,
    ),
    _ => LearningSessionViewState(
      title: activity.label,
      instruction: 'Chọn trò chơi để bắt đầu',
      prompt: module.label,
      visual: 'Sẵn sàng chơi nào!',
      answers: const ['Bắt đầu'],
      feedback: feedback,
    ),
  };
}
