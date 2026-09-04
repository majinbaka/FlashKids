import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({
    required this.onContinue,
    this.loadingDuration = const Duration(seconds: 3),
    super.key,
  });

  final VoidCallback onContinue;
  final Duration loadingDuration;

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  static const _assetsToPrecache = <AssetImage>[
    AssetImage('assets/images/mascots/mascot-launch.png'),
    AssetImage('assets/images/mascots/mascot-idle.png'),
    AssetImage('assets/images/states/launch-background.png'),
    AssetImage('assets/images/states/launch-background-portrait.png'),
    AssetImage('assets/images/subjects/vietnamese-subject-background-v2.png'),
    AssetImage('assets/images/subjects/english-subject-background-v2.png'),
    AssetImage('assets/images/subjects/math-subject-background-v2.png'),
  ];
  Timer? _loadingTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _prepareAndContinue());
  }

  void _prepareAndContinue() {
    for (final asset in _assetsToPrecache) {
      precacheImage(asset, context);
    }
    _loadingTimer = Timer(widget.loadingDuration, () {
      if (mounted) {
        widget.onContinue();
      }
    });
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final reducedMotion =
        MediaQuery.disableAnimationsOf(context) ||
        MediaQuery.accessibleNavigationOf(context);

    return Scaffold(
      backgroundColor: colors.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          LayoutBuilder(
            builder: (context, constraints) => ExcludeSemantics(
              child: Image.asset(
                constraints.maxWidth > constraints.maxHeight
                    ? 'assets/images/states/launch-background.png'
                    : 'assets/images/states/launch-background-portrait.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape =
                    constraints.maxWidth > constraints.maxHeight;
                final mascotSize = math.min(
                  400.0,
                  isLandscape
                      ? constraints.maxHeight * 0.42
                      : constraints.maxWidth * 0.8,
                );
                final title = _LaunchTitle();
                final loadingIndicator = _LoadingIndicator(
                  duration: widget.loadingDuration,
                  reducedMotion: reducedMotion,
                );
                final mascot = _LaunchMascot(
                  size: mascotSize,
                  reducedMotion: reducedMotion,
                );

                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: isLandscape
                      ? Stack(
                          children: [
                            Align(alignment: Alignment.topCenter, child: title),
                            Align(alignment: Alignment.center, child: mascot),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: loadingIndicator,
                            ),
                          ],
                        )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              mascot,
                              const SizedBox(height: 24),
                              title,
                              const SizedBox(height: 24),
                              loadingIndicator,
                            ],
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LaunchTitle extends StatelessWidget {
  const _LaunchTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'FlashKids',
          style: Theme.of(
            context,
          ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _LaunchMascot extends StatelessWidget {
  const _LaunchMascot({required this.size, required this.reducedMotion});

  final double size;
  final bool reducedMotion;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: TweenAnimationBuilder<double>(
        duration: reducedMotion
            ? Duration.zero
            : const Duration(milliseconds: 350),
        curve: Curves.easeOutBack,
        tween: Tween(begin: reducedMotion ? 1.0 : 0.88, end: 1),
        builder: (context, scale, child) =>
            Transform.scale(scale: scale, child: child),
        child: Image.asset(
          'assets/images/mascots/mascot-launch.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({
    required this.duration,
    required this.reducedMotion,
  });

  final Duration duration;
  final bool reducedMotion;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      label: 'Đang chuẩn bị trò chơi',
      liveRegion: true,
      child: ExcludeSemantics(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (reducedMotion)
              Icon(Icons.hourglass_top_rounded, color: colors.primary)
            else
              SizedBox(
                width: 24,
                height: 24,
                child: TweenAnimationBuilder<double>(
                  duration: duration,
                  curve: Curves.easeInOutCubic,
                  tween: Tween(begin: 0, end: 1),
                  builder: (context, value, _) => CircularProgressIndicator(
                    value: value,
                    strokeWidth: 4,
                    color: colors.primary,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              'Đang chuẩn bị trò chơi...',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
