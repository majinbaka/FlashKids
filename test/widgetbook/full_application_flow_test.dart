import '../../widgetbook/app_prototype/full_application_flow.dart';
import '../../widgetbook/app_prototype/prototype_data.dart';
import 'package:flash_kids/app/presentation/flash_kids_theme.dart';
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
      'Chữ cái',
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
        MaterialApp(theme: flashKidsTheme(), home: const FullApplicationFlow()),
      );

      await _finishLaunch(tester);
      expect(find.text('Hôm nay mình học gì?'), findsOneWidget);

      await tester.tap(find.text('Tiếng Việt'));
      await tester.pump();
      expect(find.text('Chọn cách học'), findsOneWidget);

      await tester.tap(find.text('Chữ cái'));
      await tester.pump();
      expect(find.text('Chọn chữ để bắt đầu'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('Chữ A, chưa nhớ'));
      await tester.pump();
      expect(find.bySemanticsLabel('Thẻ chữ A. A như An'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);

      await tester.tap(find.text('Đã nhớ'));
      await tester.pump();
      expect(find.text('Bạn đã luyện tập Chữ cái'), findsOneWidget);
    },
  );

  testWidgets('offers English letters and reviews only unremembered letters', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: flashKidsTheme(), home: const FullApplicationFlow()),
    );

    await _finishLaunch(tester);
    await tester.tap(find.text('Tiếng Anh'));
    await tester.pump();
    await tester.tap(find.text('Chữ cái'));
    await tester.pump();

    expect(find.bySemanticsLabel('Chữ A, chưa nhớ'), findsOneWidget);
    await tester.tap(find.text('Học tất cả'));
    await tester.pump();
    expect(find.byType(Image), findsOneWidget);
    await tester.tap(find.text('Đã nhớ'));
    await tester.pump();
    expect(find.text('B for Ball'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Quay lại màn hình trước'));
    await tester.pump();
    expect(find.bySemanticsLabel('Chữ A, đã nhớ'), findsOneWidget);
    final scrollable = tester.state<ScrollableState>(find.byType(Scrollable));
    scrollable.position.jumpTo(scrollable.position.maxScrollExtent);
    await tester.pump();
    await tester.tap(find.text('Học chữ chưa nhớ (25)'));
    await tester.pump();
    expect(find.text('B for Ball'), findsOneWidget);
  });

  testWidgets('onboards a child and opens an age-appropriate lesson', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: flashKidsTheme(), home: const FullApplicationFlow()),
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 3, milliseconds: 1));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tiếp tục'));
    await tester.pump();
    expect(find.text('Hãy nhập tên của bé'), findsOneWidget);
    expect(find.text('Bé thuộc khoảng tuổi nào?'), findsNothing);

    await tester.enterText(find.byType(TextField), 'Lan');
    await tester.tap(find.text('Tiếp tục'));
    await tester.pump();
    expect(find.text('Bé thuộc khoảng tuổi nào?'), findsOneWidget);
    expect(find.text('Tên của bé'), findsNothing);
    await tester.ensureVisible(find.text('8–10 tuổi'));
    await tester.tap(find.text('8–10 tuổi'));
    await tester.ensureVisible(find.text('Xem bài học phù hợp'));
    await tester.tap(find.text('Xem bài học phù hợp'));
    await tester.pumpAndSettle();

    expect(find.text('Chào Lan'), findsOneWidget);
    expect(find.text('Phát âm tiếng Anh'), findsOneWidget);

    await tester.tap(find.text('Phát âm tiếng Anh'));
    await tester.pump();
    expect(find.text('Nghe rồi nói theo'), findsOneWidget);
  });

  testWidgets('home remains usable at two hundred percent text scale', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(2)),
        child: MaterialApp(
          theme: flashKidsTheme(),
          home: const FullApplicationFlow(),
        ),
      ),
    );

    await _finishLaunch(tester);

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
        theme: flashKidsTheme(),
        home: ChildHomeScreen(
          modules: prototypeModules,
          onModuleSelected: (_) {},
          onGames: () {},
          onParentArea: () {},
        ),
      ),
    );

    for (final label in ['Tiếng Việt', 'Tiếng Anh', 'Toán', 'Mini game']) {
      expect(find.text(label), findsOneWidget);
      expect(tester.getRect(find.text(label)).bottom, lessThanOrEqualTo(390));
    }
    expect(find.text('Bộ sưu tập'), findsNothing);
    expect(find.text('HỌC'), findsNothing);
    expect(find.text('CHƠI'), findsNothing);
  });

  testWidgets('keeps subject labels right-aligned and learning cards minimal', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: flashKidsTheme(), home: const FullApplicationFlow()),
    );

    await _finishLaunch(tester);

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

    expect(find.text('Chữ cái, đánh vần'), findsNothing);
    expect(find.text('Nhận biết chữ cái'), findsNothing);
    expect(find.byIcon(Icons.abc_rounded), findsNothing);
    expect(find.byIcon(Icons.arrow_forward_rounded), findsNothing);
    expect(find.text('Chữ cái'), findsOneWidget);
  });

  testWidgets('lets a parent change settings and switch the active child', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: flashKidsTheme(), home: const FullApplicationFlow()),
    );

    await _finishLaunch(tester);
    await tester.scrollUntilVisible(
      find.text('Phụ huynh'),
      300,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.text('Phụ huynh'));
    await tester.pump();

    final gate = await tester.startGesture(
      tester.getCenter(find.text('Nhấn và giữ')),
    );
    await tester.pump(const Duration(seconds: 3, milliseconds: 1));
    await gate.up();
    await tester.pump();
    await tester.tap(find.text('7'));
    await tester.pump();
    await tester.tap(find.text('Cài đặt'));
    await tester.pump();

    expect(find.text('Tài khoản đang dùng'), findsOneWidget);
    expect(find.text('Cỡ chữ'), findsOneWidget);
    expect(find.text('Loại tài khoản'), findsOneWidget);
    expect(find.text('Âm thanh hướng dẫn'), findsOneWidget);

    await tester.tap(find.text('An'));
    await tester.pump();

    await tester.tap(find.byTooltip('Quay lại tổng quan phụ huynh'));
    await tester.pump();
    await tester.tap(find.text('Về Kid Zone'));
    await tester.pump();
    expect(find.text('Chào An'), findsOneWidget);
  });
}

Future<void> _finishLaunch(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(seconds: 3, milliseconds: 1));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField), 'Minh');
  await tester.tap(find.text('Tiếp tục'));
  await tester.pumpAndSettle();
  await tester.ensureVisible(find.text('6–7 tuổi'));
  await tester.tap(find.text('6–7 tuổi'));
  await tester.ensureVisible(find.text('Xem bài học phù hợp'));
  await tester.tap(find.text('Xem bài học phù hợp'));
  await tester.pumpAndSettle();
}
