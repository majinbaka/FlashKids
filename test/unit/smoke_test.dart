import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

abstract class GreetingRepository {
  String greeting();
}

class MockGreetingRepository extends Mock implements GreetingRepository {}

void main() {
  test('mocktail is ready for unit tests', () {
    final repository = MockGreetingRepository();
    when(() => repository.greeting()).thenReturn('FlashKids');

    expect(repository.greeting(), 'FlashKids');
    verify(() => repository.greeting()).called(1);
  });
}
