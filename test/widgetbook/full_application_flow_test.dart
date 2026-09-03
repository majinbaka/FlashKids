import '../../widgetbook/app_prototype/full_application_flow.dart';
import '../../widgetbook/app_prototype/prototype_data.dart';
import 'package:flash_kids/features/home/presentation/child_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('groups learning activities by subject', () {
    expect(activitiesFor('vietnamese').map((activity) => activity.label), [
      'Chữ cái',
      'Đánh vần',
      'Phát âm',
      'Mini games',
    ]);
    expect(activitiesFor('english').map((activity) => activity.label), [
      'Từ vựng',
      'Phát âm',
      'Mini games',
    ]);
    expect(activitiesFor('math').map((activity) => activity.label), [
      'Cộng',
      'Trừ',
      'Mini games',
    ]);
  });

  testWidgets(
    'completes the representative Vietnamese alphabet learning flow',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const FullApplicationFlow(),
        ),
      );

      await tester.tap(find.text('Bắt đầu'));
      await tester.pump();
      expect(find.text('Hôm nay mình học gì?'), findsOneWidget);

      await tester.tap(find.text('Tiếng Việt'));
      await tester.pump();
      expect(find.text('Chọn cách học'), findsOneWidget);

      await tester.tap(find.text('Chữ cái'));
      await tester.pump();
      expect(find.text('Chọn chữ A'), findsOneWidget);

      await tester.tap(find.text('A').last);
      await tester.pump();
      expect(find.text('Hay lắm!'), findsOneWidget);

      await tester.tap(find.text('Tiếp tục'));
      await tester.pump();
      expect(find.text('Bạn đã luyện tập Chữ cái'), findsOneWidget);
    },
  );

  testWidgets('home remains usable at two hundred percent text scale', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(2)),
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const FullApplicationFlow(),
        ),
      ),
    );

    await tester.tap(find.text('Bắt đầu'));
    await tester.pump();

    expect(find.bySemanticsLabel('Tiếng Việt'), findsOneWidget);
    expect(tester.takeException(), isNull);
    semantics.dispose();
  });

  testWidgets('shows every home destination in a landscape phone viewport', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(844, 390));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ChildHomeScreen(
          modules: prototypeModules,
          onModuleSelected: (_) {},
          onGames: () {},
          onCollection: () {},
          onParentArea: () {},
        ),
      ),
    );

    for (final label in [
      'Tiếng Việt',
      'Tiếng Anh',
      'Toán',
      'Mini game',
      'Bộ sưu tập',
    ]) {
      expect(find.text(label), findsOneWidget);
      expect(tester.getRect(find.text(label)).bottom, lessThanOrEqualTo(390));
    }
  });

  testWidgets('keeps subject labels right-aligned and learning cards minimal', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const FullApplicationFlow(),
      ),
    );

    await tester.tap(find.text('Bắt đầu'));
    await tester.pump();

    final subjectLabel = find.text('Tiếng Việt');
    final subjectCard = find.ancestor(
      of: subjectLabel,
      matching: find.byType(InkWell),
    );
    expect(
      tester.getCenter(subjectLabel).dx,
      greaterThan(tester.getCenter(subjectCard).dx),
    );

    await tester.tap(subjectLabel);
    await tester.pump();

    expect(find.text('Nhận biết chữ cái'), findsNothing);
    expect(find.byIcon(Icons.abc_rounded), findsNothing);
    expect(find.byIcon(Icons.arrow_forward_rounded), findsNothing);
    expect(find.text('Chữ cái'), findsOneWidget);
  });
}
