import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgetbook/addons/orientation_viewport_addon.dart';

void main() {
  const viewport = ViewportData(
    name: 'Test device',
    width: 412,
    height: 892,
    pixelRatio: 2.625,
    platform: TargetPlatform.android,
    safeAreas: EdgeInsets.fromLTRB(4, 32, 8, 24),
  );

  test('keeps the selected viewport dimensions in portrait', () {
    final portrait = orientedViewportData(
      viewport,
      ViewportOrientation.portrait,
    );

    expect(portrait, same(viewport));
  });

  test('swaps viewport dimensions and rotates safe areas in landscape', () {
    final landscape = orientedViewportData(
      viewport,
      ViewportOrientation.landscape,
    );

    expect(landscape.name, 'Test device · Landscape');
    expect(landscape.size, const Size(892, 412));
    expect(landscape.safeAreas, const EdgeInsets.fromLTRB(24, 4, 32, 8));
    expect(landscape.pixelRatio, viewport.pixelRatio);
    expect(landscape.platform, viewport.platform);
  });
}
