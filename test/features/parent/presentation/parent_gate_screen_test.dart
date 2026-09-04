import 'package:flash_kids/features/parent/presentation/parent_gate_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('requires a three-second hold before showing the challenge', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    var verified = false;
    await tester.pumpWidget(
      MaterialApp(
        home: ParentGateScreen(
          onVerified: () => verified = true,
          onCancel: () {},
        ),
      ),
    );

    expect(
      find.bySemanticsLabel(RegExp('Nhấn giữ ba giây để tiếp tục')),
      findsOneWidget,
    );

    final gesture = await tester.startGesture(
      tester.getCenter(find.text('Nhấn và giữ')),
    );
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Ba cộng bốn bằng bao nhiêu?'), findsNothing);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Ba cộng bốn bằng bao nhiêu?'), findsOneWidget);
    await gesture.up();

    await tester.tap(find.text('6'));
    await tester.pump();
    expect(find.text('Chưa khớp. Vui lòng thử lại.'), findsOneWidget);
    expect(verified, isFalse);

    await tester.tap(find.text('7'));
    expect(verified, isTrue);
    semantics.dispose();
  });
}
