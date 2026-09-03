import '../../widgetbook/components/completion_animation_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('advances the completion sprite preview every 250 milliseconds', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CompletionAnimationComponents(
          assetPath:
              'assets/images/feedback/feedback-complete-confetti-sprites.png',
          autoPlay: true,
          frame: 0,
        ),
      ),
    );

    expect(
      find.bySemanticsLabel('Xem trước hoạt ảnh hoàn thành, khung 1 trên 16'),
      findsOneWidget,
    );

    await tester.pump(const Duration(milliseconds: 250));

    expect(
      find.bySemanticsLabel('Xem trước hoạt ảnh hoàn thành, khung 2 trên 16'),
      findsOneWidget,
    );
  });
}
