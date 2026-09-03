import 'package:flash_kids/app/presentation/flash_kids_theme.dart';
import 'package:flash_kids/features/home/presentation/launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('prepares home assets then continues after three seconds', (
    tester,
  ) async {
    var didContinue = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: flashKidsTheme(),
        home: LaunchScreen(onContinue: () => didContinue = true),
      ),
    );

    expect(find.bySemanticsLabel('Đang chuẩn bị trò chơi'), findsOneWidget);
    expect(didContinue, isFalse);

    await tester.pump();
    await tester.pump(const Duration(seconds: 3, milliseconds: 1));
    await tester.pumpAndSettle();

    expect(didContinue, isTrue);
  });

  testWidgets(
    'launch layout remains usable at two hundred percent text scale',
    (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: MaterialApp(
            theme: flashKidsTheme(),
            home: const LaunchScreen(onContinue: _doNothing),
          ),
        ),
      );

      expect(find.text('FlashKids'), findsOneWidget);
      expect(find.bySemanticsLabel('Đang chuẩn bị trò chơi'), findsOneWidget);
      expect(tester.takeException(), isNull);
      semantics.dispose();
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('uses a landscape layout without scrolling', (tester) async {
    tester.view.physicalSize = const Size(892, 412);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        theme: flashKidsTheme(),
        home: const LaunchScreen(onContinue: _doNothing),
      ),
    );

    expect(find.byType(SingleChildScrollView), findsNothing);
    expect(find.text('FlashKids'), findsOneWidget);
    expect(find.text('Nhìn • Nghe • Chơi • Học'), findsNothing);
    expect(find.bySemanticsLabel('Đang chuẩn bị trò chơi'), findsOneWidget);
    expect(tester.getCenter(find.text('FlashKids')).dx, closeTo(446, 1));
    expect(tester.takeException(), isNull);
  });
}

void _doNothing() {}
