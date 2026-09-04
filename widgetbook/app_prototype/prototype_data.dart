import 'package:flash_kids/features/games/presentation/game_hub_screen.dart';
import 'package:flash_kids/features/home/presentation/child_home_screen.dart';
import 'package:flash_kids/features/home/presentation/recommended_lesson_list.dart';
import 'package:flash_kids/features/learning/presentation/alphabet_overview_screen.dart';
import 'package:flash_kids/features/learning/presentation/learning_session_screen.dart';
import 'package:flash_kids/features/learning/presentation/module_overview_screen.dart';
import 'package:flutter/material.dart';

const vietnameseBackground =
    'assets/images/subjects/vietnamese-subject-background-v2.png';
const englishBackground =
    'assets/images/subjects/english-subject-background-v2.png';
const mathBackground = 'assets/images/subjects/math-subject-background-v2.png';
const vietnameseAlphabetBackground =
    'assets/images/subjects/vietnamese-alphabet-background.png';
const vietnameseSpellingBackground =
    'assets/images/subjects/vietnamese-spelling-background.png';
const vietnamesePronunciationBackground =
    'assets/images/subjects/vietnamese-pronunciation-background.png';
const vietnameseGamesBackground =
    'assets/images/subjects/vietnamese-games-background.png';
const englishVocabularyBackground =
    'assets/images/subjects/english-vocabulary-background.png';
const englishPronunciationBackground =
    'assets/images/subjects/english-pronunciation-background.png';
const englishGamesBackground =
    'assets/images/subjects/english-games-background.png';
const mathAdditionBackground =
    'assets/images/subjects/math-addition-background.png';
const mathSubtractionBackground =
    'assets/images/subjects/math-subtraction-background.png';
const mathGamesBackground = 'assets/images/subjects/math-games-background.png';

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

List<LessonRecommendation> recommendationsForAgeBand(String ageBand) {
  return switch (ageBand) {
    '3–5 tuổi' => const [
      LessonRecommendation(
        moduleId: 'vietnamese',
        activityId: 'vietnamese-alphabet',
        title: 'Làm quen chữ cái',
        description: 'Nhìn hình và chọn chữ',
        icon: Icons.abc_rounded,
      ),
      LessonRecommendation(
        moduleId: 'math',
        activityId: 'math-addition',
        title: 'Đếm và cộng',
        description: 'Gộp các nhóm đồ vật',
        icon: Icons.add_circle_rounded,
      ),
    ],
    '6–7 tuổi' => const [
      LessonRecommendation(
        moduleId: 'vietnamese',
        activityId: 'vietnamese-spelling',
        title: 'Ghép vần',
        description: 'Điền chữ còn thiếu',
        icon: Icons.extension_rounded,
      ),
      LessonRecommendation(
        moduleId: 'english',
        activityId: 'english-vocabulary',
        title: 'Từ vựng tiếng Anh',
        description: 'Học từ bằng hình ảnh',
        icon: Icons.image_rounded,
      ),
    ],
    _ => const [
      LessonRecommendation(
        moduleId: 'english',
        activityId: 'english-pronunciation',
        title: 'Phát âm tiếng Anh',
        description: 'Nghe mẫu rồi nói theo',
        icon: Icons.record_voice_over_rounded,
      ),
      LessonRecommendation(
        moduleId: 'math',
        activityId: 'math-subtraction',
        title: 'Phép trừ',
        description: 'Xem còn lại bao nhiêu',
        icon: Icons.remove_circle_rounded,
      ),
    ],
  };
}

List<LearningActivitySummary> activitiesFor(String moduleId) {
  return switch (moduleId) {
    'vietnamese' => const [
      LearningActivitySummary(
        id: 'vietnamese-alphabet',
        label: 'Chữ cái',
        description: 'Nhận biết chữ cái',
        icon: Icons.abc_rounded,
        backgroundAsset: vietnameseAlphabetBackground,
      ),
      LearningActivitySummary(
        id: 'vietnamese-spelling',
        label: 'Đánh vần',
        description: 'Ghép các tiếng đơn giản',
        icon: Icons.extension_rounded,
        backgroundAsset: vietnameseSpellingBackground,
      ),
      LearningActivitySummary(
        id: 'vietnamese-pronunciation',
        label: 'Phát âm',
        description: 'Nghe mẫu rồi nói theo',
        icon: Icons.record_voice_over_rounded,
        backgroundAsset: vietnamesePronunciationBackground,
      ),
      LearningActivitySummary(
        id: 'vietnamese-games',
        label: 'Mini games',
        description: 'Chơi và ôn Tiếng Việt',
        icon: Icons.sports_esports_rounded,
        backgroundAsset: vietnameseGamesBackground,
      ),
    ],
    'english' => const [
      LearningActivitySummary(
        id: 'english-alphabet',
        label: 'Chữ cái',
        description: 'Nhận biết bảng chữ cái tiếng Anh',
        icon: Icons.abc_rounded,
        backgroundAsset: englishVocabularyBackground,
      ),
      LearningActivitySummary(
        id: 'english-vocabulary',
        label: 'Từ vựng',
        description: 'Học từ bằng hình ảnh',
        icon: Icons.image_rounded,
        backgroundAsset: englishVocabularyBackground,
      ),
      LearningActivitySummary(
        id: 'english-pronunciation',
        label: 'Phát âm',
        description: 'Nghe và nói theo',
        icon: Icons.mic_rounded,
        backgroundAsset: englishPronunciationBackground,
      ),
      LearningActivitySummary(
        id: 'english-games',
        label: 'Mini games',
        description: 'Chơi và ôn Tiếng Anh',
        icon: Icons.sports_esports_rounded,
        backgroundAsset: englishGamesBackground,
      ),
    ],
    'math' => const [
      LearningActivitySummary(
        id: 'math-addition',
        label: 'Cộng',
        description: 'Gộp các nhóm đồ vật',
        icon: Icons.add_circle_rounded,
        backgroundAsset: mathAdditionBackground,
      ),
      LearningActivitySummary(
        id: 'math-subtraction',
        label: 'Trừ',
        description: 'Xem còn lại bao nhiêu',
        icon: Icons.remove_circle_rounded,
        backgroundAsset: mathSubtractionBackground,
      ),
      LearningActivitySummary(
        id: 'math-games',
        label: 'Mini games',
        description: 'Chơi và ôn Toán',
        icon: Icons.sports_esports_rounded,
        backgroundAsset: mathGamesBackground,
      ),
    ],
    _ => const [],
  };
}

List<AlphabetLetter> alphabetFor(String activityId) {
  return switch (activityId) {
    'vietnamese-alphabet' => const [
      AlphabetLetter(value: 'A', example: 'A như An'),
      AlphabetLetter(value: 'Ă', example: 'Ă như ăn'),
      AlphabetLetter(value: 'Â', example: 'Â như âm'),
      AlphabetLetter(value: 'B', example: 'B như bé'),
      AlphabetLetter(value: 'C', example: 'C như cá'),
      AlphabetLetter(value: 'D', example: 'D như dê'),
      AlphabetLetter(value: 'Đ', example: 'Đ như đèn'),
      AlphabetLetter(value: 'E', example: 'E như em'),
      AlphabetLetter(value: 'Ê', example: 'Ê như ếch'),
      AlphabetLetter(value: 'G', example: 'G như gà'),
      AlphabetLetter(value: 'H', example: 'H như hoa'),
      AlphabetLetter(value: 'I', example: 'I như in'),
      AlphabetLetter(value: 'K', example: 'K như kem'),
      AlphabetLetter(value: 'L', example: 'L như lá'),
      AlphabetLetter(value: 'M', example: 'M như mèo'),
      AlphabetLetter(value: 'N', example: 'N như na'),
      AlphabetLetter(value: 'O', example: 'O như ô'),
      AlphabetLetter(value: 'Ô', example: 'Ô như ô tô'),
      AlphabetLetter(value: 'Ơ', example: 'Ơ như ớt'),
      AlphabetLetter(value: 'P', example: 'P như pin'),
      AlphabetLetter(value: 'Q', example: 'Q như quà'),
      AlphabetLetter(value: 'R', example: 'R như rổ'),
      AlphabetLetter(value: 'S', example: 'S như sư tử'),
      AlphabetLetter(value: 'T', example: 'T như táo'),
      AlphabetLetter(value: 'U', example: 'U như ù'),
      AlphabetLetter(value: 'Ư', example: 'Ư như ước'),
      AlphabetLetter(value: 'V', example: 'V như voi'),
      AlphabetLetter(value: 'X', example: 'X như xe'),
      AlphabetLetter(value: 'Y', example: 'Y như yến'),
    ],
    'english-alphabet' => const [
      AlphabetLetter(value: 'A', example: 'A for Apple'),
      AlphabetLetter(value: 'B', example: 'B for Ball'),
      AlphabetLetter(value: 'C', example: 'C for Cat'),
      AlphabetLetter(value: 'D', example: 'D for Dog'),
      AlphabetLetter(value: 'E', example: 'E for Elephant'),
      AlphabetLetter(value: 'F', example: 'F for Fish'),
      AlphabetLetter(value: 'G', example: 'G for Goat'),
      AlphabetLetter(value: 'H', example: 'H for Hat'),
      AlphabetLetter(value: 'I', example: 'I for Ice cream'),
      AlphabetLetter(value: 'J', example: 'J for Juice'),
      AlphabetLetter(value: 'K', example: 'K for Kite'),
      AlphabetLetter(value: 'L', example: 'L for Lion'),
      AlphabetLetter(value: 'M', example: 'M for Moon'),
      AlphabetLetter(value: 'N', example: 'N for Nest'),
      AlphabetLetter(value: 'O', example: 'O for Orange'),
      AlphabetLetter(value: 'P', example: 'P for Penguin'),
      AlphabetLetter(value: 'Q', example: 'Q for Queen'),
      AlphabetLetter(value: 'R', example: 'R for Rabbit'),
      AlphabetLetter(value: 'S', example: 'S for Sun'),
      AlphabetLetter(value: 'T', example: 'T for Tree'),
      AlphabetLetter(value: 'U', example: 'U for Umbrella'),
      AlphabetLetter(value: 'V', example: 'V for Van'),
      AlphabetLetter(value: 'W', example: 'W for Whale'),
      AlphabetLetter(value: 'X', example: 'X for Xylophone'),
      AlphabetLetter(value: 'Y', example: 'Y for Yak'),
      AlphabetLetter(value: 'Z', example: 'Z for Zebra'),
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
