import 'dart:async';

import 'package:flutter/material.dart';

class CompletionAnimationComponents extends StatefulWidget {
  const CompletionAnimationComponents({
    required this.assetPath,
    required this.autoPlay,
    required this.frame,
    super.key,
  });

  final String assetPath;
  final bool autoPlay;
  final int frame;

  @override
  State<CompletionAnimationComponents> createState() =>
      _CompletionAnimationComponentsState();
}

class _CompletionAnimationComponentsState
    extends State<CompletionAnimationComponents> {
  Timer? _frameTimer;
  int _animatedFrame = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncFrameTimer();
  }

  @override
  void didUpdateWidget(covariant CompletionAnimationComponents oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.autoPlay != widget.autoPlay) {
      _syncFrameTimer();
    }
  }

  @override
  void dispose() {
    _frameTimer?.cancel();
    super.dispose();
  }

  void _syncFrameTimer() {
    final animationsDisabled =
        MediaQuery.disableAnimationsOf(context) ||
        MediaQuery.of(context).accessibleNavigation;
    final shouldAnimate = widget.autoPlay && !animationsDisabled;

    if (shouldAnimate && _frameTimer == null) {
      _frameTimer = Timer.periodic(const Duration(milliseconds: 250), (_) {
        if (mounted) {
          setState(() => _animatedFrame = (_animatedFrame + 1) % 16);
        }
      });
    } else if (!shouldAnimate) {
      _frameTimer?.cancel();
      _frameTimer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final animationsDisabled =
        MediaQuery.disableAnimationsOf(context) ||
        MediaQuery.of(context).accessibleNavigation;
    final frame = widget.autoPlay && !animationsDisabled
        ? _animatedFrame
        : widget.frame;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Semantics(
            label: 'Xem trước hoạt ảnh hoàn thành, khung ${frame + 1} trên 16',
            image: true,
            child: ExcludeSemantics(
              child: _CompletionAnimationSprite(
                assetPath: widget.assetPath,
                frame: frame,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CompletionAnimationSprite extends StatelessWidget {
  const _CompletionAnimationSprite({
    required this.assetPath,
    required this.frame,
  });

  final String assetPath;
  final int frame;

  @override
  Widget build(BuildContext context) {
    final column = frame % 4;
    final row = frame ~/ 4;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth;
        return SizedBox.square(
          dimension: size,
          child: ClipRect(
            child: OverflowBox(
              alignment: Alignment.topLeft,
              minWidth: size * 4,
              maxWidth: size * 4,
              minHeight: size * 4,
              maxHeight: size * 4,
              child: Transform.translate(
                offset: Offset(-column * size, -row * size),
                child: SizedBox.square(
                  dimension: size * 4,
                  child: Image.asset(assetPath, fit: BoxFit.fill),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
