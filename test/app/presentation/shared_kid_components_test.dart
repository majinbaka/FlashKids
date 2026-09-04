import 'package:flash_kids/app/presentation/kid_answer_control.dart';
import 'package:flash_kids/app/presentation/kid_destination_card.dart';
import 'package:flash_kids/app/presentation/flashcard.dart';
import 'package:flash_kids/app/presentation/kid_feedback_panel.dart';
import 'package:flash_kids/app/presentation/flash_kids_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'flashcard fills its available width with white vertical content',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: flashKidsTheme(),
          home: Scaffold(
            body: SizedBox(
              width: 320,
              child: Flashcard(
                state: const FlashcardViewState(
                  imageAsset: 'assets/images/cards/card-animal-cat.png',
                  title: 'A',
                  detail: 'A như An',
                  semanticsLabel: 'Thẻ chữ A. A như An',
                ),
              ),
            ),
          ),
        ),
      );

      final card = find.byType(Flashcard);
      expect(tester.getRect(card).width, 320);
      expect(find.bySemanticsLabel('Thẻ chữ A. A như An'), findsOneWidget);
      expect(
        tester.getTopLeft(find.byType(Image)).dy,
        lessThan(tester.getTopLeft(find.text('A')).dy),
      );
      expect(
        tester
            .widget<Material>(
              find.descendant(of: card, matching: find.byType(Material)),
            )
            .color,
        Colors.white,
      );
    },
  );

  test('uses the approved FlashKids palette for Material color roles', () {
    final colors = flashKidsTheme().colorScheme;

    expect(colors.primary, const Color(0xFFDF301C));
    expect(colors.secondary, const Color(0xFFFF9100));
    expect(colors.surface, const Color(0xFFFFF1D1));
    expect(colors.tertiary, const Color(0xFF00B7CD));
    expect(flashKidsTheme().scaffoldBackgroundColor, const Color(0xFFFFF1D1));
    expect(
      (flashKidsTheme().cardTheme.shape! as RoundedRectangleBorder).side,
      const BorderSide(color: Color(0xFF85736A), width: 3),
    );
  });

  testWidgets('destination card has a bold outline', (tester) async {
    await tester.pumpWidget(
      _TestApp(
        child: KidDestinationCard(
          state: const KidDestinationCardViewState(
            label: 'Chữ cái',
            detail: 'A, B, C',
            icon: Icons.abc_rounded,
            semanticsLabel: 'Chữ cái. A, B, C',
          ),
          onPressed: () {},
        ),
      ),
    );

    final material = tester.widget<Material>(
      find.descendant(
        of: find.byType(KidDestinationCard),
        matching: find.byType(Material),
      ),
    );
    final shape = material.shape! as RoundedRectangleBorder;
    expect(shape.side.width, 3);
  });

  testWidgets('destination card exposes one action and invokes it', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    var presses = 0;

    await tester.pumpWidget(
      _TestApp(
        child: KidDestinationCard(
          state: const KidDestinationCardViewState(
            label: 'Chữ cái',
            detail: 'A, B, C',
            icon: Icons.abc_rounded,
            semanticsLabel: 'Chữ cái. A, B, C',
          ),
          onPressed: () => presses++,
        ),
      ),
    );

    expect(find.bySemanticsLabel('Chữ cái. A, B, C'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Chữ cái. A, B, C'));
    expect(presses, 1);
    semantics.dispose();
  });

  testWidgets('answer variants preserve their child-sized tap targets', (
    tester,
  ) async {
    await tester.pumpWidget(
      _TestApp(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            KidAnswerControl(
              key: const Key('standard-answer'),
              state: const KidAnswerControlViewState(
                label: 'A',
                semanticsLabel: 'Chọn A',
              ),
              onPressed: () {},
            ),
            KidAnswerControl(
              key: const Key('prominent-answer'),
              state: const KidAnswerControlViewState(
                label: '5',
                semanticsLabel: 'Chọn đáp án 5',
              ),
              onPressed: () {},
              variant: KidAnswerControlVariant.prominent,
            ),
          ],
        ),
      ),
    );

    expect(
      tester.getSize(find.byKey(const Key('standard-answer'))),
      const Size(104, 72),
    );
    expect(
      tester.getSize(find.byKey(const Key('prominent-answer'))),
      const Size(112, 80),
    );
  });

  testWidgets('feedback panel announces its configured message', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      const _TestApp(
        child: KidFeedbackPanel(
          state: KidFeedbackPanelViewState(
            message: 'Hay lắm!',
            semanticsLabel: 'Hay lắm, tiếp tục nhé',
            kind: KidFeedbackKind.success,
          ),
        ),
      ),
    );

    expect(find.bySemanticsLabel('Hay lắm, tiếp tục nhé'), findsOneWidget);
    expect(find.byIcon(Icons.star_rounded), findsOneWidget);
    semantics.dispose();
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: flashKidsTheme(),
      home: Scaffold(body: Center(child: child)),
    );
  }
}
