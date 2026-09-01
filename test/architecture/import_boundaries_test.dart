// Machine-enforces the dependency direction of ADR-0001, clause 4.
//
// This is vacuous while `lib/features/` does not exist: it asserts nothing
// about a repository that has no slices yet, and starts failing the moment the
// first slice imports across a forbidden boundary. Generated output is skipped
// because build_runner, not a human, decides its imports.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Packages `domain/` and `application/` code may never depend on. Flutter's
/// `foundation` library is allowed: it carries `@immutable` and value-equality
/// helpers, not widgets.
const forbiddenInDomainAndApplication = <String>[
  'package:flutter/material.dart',
  'package:flutter/widgets.dart',
  'package:flutter/cupertino.dart',
  'package:flutter/services.dart',
  'package:go_router/',
  'package:widgetbook',
  'package:http/',
  'package:dio/',
  'package:shared_preferences/',
  'package:sqflite/',
  'package:drift/',
  'package:hive/',
  'package:isar/',
];

void main() {
  group('import boundaries (ADR-0001 clause 4)', () {
    test('domain and application do not import UI, routing, or adapters', () {
      final violations = <String>[];

      for (final file in _productionSources()) {
        final path = _posixPath(file);
        if (!_isDomainOrApplication(path)) continue;

        for (final uri in _importedUris(file)) {
          for (final forbidden in forbiddenInDomainAndApplication) {
            if (uri.startsWith(forbidden)) {
              violations.add('$path imports $uri');
            }
          }
        }
      }

      expect(
        violations,
        isEmpty,
        reason:
            'domain/ and application/ code must not depend on Flutter widgets, '
            'GoRouter, Widgetbook, HTTP clients, or storage implementations. '
            'Depend on a port in domain/ and let an infrastructure adapter '
            'implement it.',
      );
    });

    test('lib does not import widgetbook or test code', () {
      final violations = <String>[];

      for (final file in _productionSources()) {
        for (final uri in _importedUris(file)) {
          if (_reachesWidgetbookOrTest(uri)) {
            violations.add('${_posixPath(file)} imports $uri');
          }
        }
      }

      expect(
        violations,
        isEmpty,
        reason:
            'production code in lib/ must never import widgetbook/ or '
            'test/ code.',
      );
    });
  });
}

bool _isDomainOrApplication(String path) =>
    path.contains('/domain/') || path.contains('/application/');

bool _reachesWidgetbookOrTest(String uri) =>
    uri.startsWith('package:widgetbook') ||
    uri.contains('widgetbook/') ||
    uri.contains('test/');

/// Every hand-written Dart file under `lib/`.
Iterable<File> _productionSources() {
  final lib = Directory('lib');
  if (!lib.existsSync()) return const <File>[];

  return lib
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .where((file) => !_isGenerated(file.path));
}

bool _isGenerated(String path) =>
    path.endsWith('.g.dart') || path.endsWith('.freezed.dart');

final _importPattern = RegExp(
  r'''^\s*(?:import|export)\s+['"]([^'"]+)['"]''',
  multiLine: true,
);

Iterable<String> _importedUris(File file) => _importPattern
    .allMatches(file.readAsStringSync())
    .map((match) => match.group(1)!);

String _posixPath(File file) =>
    file.path.replaceAll(Platform.pathSeparator, '/');
