import 'package:flutter/material.dart' hide Viewport;
import 'package:widgetbook/widgetbook.dart';

enum ViewportOrientation { portrait, landscape }

class OrientationViewportAddon
    extends WidgetbookAddon<OrientationViewportSetting> {
  OrientationViewportAddon(this.viewports) : super(name: 'Viewport');

  final List<ViewportData> viewports;

  @override
  List<Field> get fields => [
    ObjectDropdownField<ViewportData>(
      name: 'device',
      initialValue: viewports.first,
      values: viewports,
      labelBuilder: (viewport) => viewport.name,
    ),
    ObjectSegmentedField<ViewportOrientation>(
      name: 'orientation',
      initialValue: ViewportOrientation.portrait,
      values: ViewportOrientation.values,
      labelBuilder: _orientationLabel,
    ),
  ];

  @override
  OrientationViewportSetting valueFromQueryGroup(Map<String, String> group) {
    return OrientationViewportSetting(
      viewport: valueOf<ViewportData>('device', group)!,
      orientation: valueOf<ViewportOrientation>('orientation', group)!,
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    OrientationViewportSetting setting,
  ) {
    final frameless = WidgetbookState.of(context).previewMode;
    return Center(
      child: _OrientationViewport(
        data: orientedViewportData(setting.viewport, setting.orientation),
        frameless: frameless,
        child: child,
      ),
    );
  }
}

ViewportData orientedViewportData(
  ViewportData viewport,
  ViewportOrientation orientation,
) {
  if (orientation == ViewportOrientation.portrait) return viewport;

  return ViewportData(
    name: '${viewport.name} · Landscape',
    width: viewport.height,
    height: viewport.width,
    pixelRatio: viewport.pixelRatio,
    platform: viewport.platform,
    safeAreas: EdgeInsets.fromLTRB(
      viewport.safeAreas.bottom,
      viewport.safeAreas.left,
      viewport.safeAreas.top,
      viewport.safeAreas.right,
    ),
  );
}

class OrientationViewportSetting {
  const OrientationViewportSetting({
    required this.viewport,
    required this.orientation,
  });

  final ViewportData viewport;
  final ViewportOrientation orientation;
}

class _OrientationViewport extends StatelessWidget {
  const _OrientationViewport({
    required this.data,
    required this.frameless,
    required this.child,
  });

  final ViewportData data;
  final bool frameless;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).copyWith(
      size: data.size,
      devicePixelRatio: data.pixelRatio,
      padding: data.safeAreas,
      viewPadding: data.safeAreas,
    );
    final theme = Theme.of(context).copyWith(platform: data.platform);

    final viewport = SizedBox(
      width: data.width,
      height: data.height,
      child: Theme(
        data: theme,
        child: MediaQuery(
          data: mediaQuery,
          child: Navigator(
            onGenerateRoute: (_) =>
                PageRouteBuilder(pageBuilder: (context, _, _) => child),
          ),
        ),
      ),
    );

    return FittedBox(
      child: frameless
          ? viewport
          : Padding(
              padding: const EdgeInsets.all(16),
              child: _ViewportFrame(title: data.name, child: viewport),
            ),
    );
  }
}

class _ViewportFrame extends StatelessWidget {
  const _ViewportFrame({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.black87),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: child,
        ),
      ],
    );
  }
}

String _orientationLabel(ViewportOrientation orientation) {
  return switch (orientation) {
    ViewportOrientation.portrait => 'Portrait',
    ViewportOrientation.landscape => 'Landscape',
  };
}
