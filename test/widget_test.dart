import 'package:flash_kids/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the app name', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FlashKidsApp()));
    await tester.pumpAndSettle();

    expect(find.text('FlashKids'), findsOneWidget);
  });
}
