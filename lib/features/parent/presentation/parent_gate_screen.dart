import 'dart:async';

import 'package:flutter/material.dart';

enum ParentGateStage { hold, challenge }

class ParentGateScreen extends StatefulWidget {
  const ParentGateScreen({
    required this.onVerified,
    required this.onCancel,
    super.key,
  });

  final VoidCallback onVerified;
  final VoidCallback onCancel;

  @override
  State<ParentGateScreen> createState() => _ParentGateScreenState();
}

class _ParentGateScreenState extends State<ParentGateScreen> {
  static const _holdDuration = Duration(seconds: 3);

  ParentGateStage _stage = ParentGateStage.hold;
  Timer? _timer;
  bool _holding = false;
  bool _showRetry = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startHolding() {
    _timer?.cancel();
    setState(() => _holding = true);
    _timer = Timer(_holdDuration, () {
      if (!mounted || !_holding) return;
      setState(() {
        _holding = false;
        _stage = ParentGateStage.challenge;
      });
    });
  }

  void _stopHolding() {
    _timer?.cancel();
    if (_holding) setState(() => _holding = false);
  }

  void _answer(int value) {
    if (value == 7) {
      widget.onVerified();
      return;
    }
    setState(() => _showRetry = true);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Quay lại Kid Zone',
          onPressed: widget.onCancel,
          icon: const Icon(Icons.close_rounded),
        ),
        title: const Text('Cổng phụ huynh'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: _stage == ParentGateStage.hold
                  ? _HoldChallenge(
                      holding: _holding,
                      onStart: _startHolding,
                      onStop: _stopHolding,
                    )
                  : _WrittenChallenge(showRetry: _showRetry, onAnswer: _answer),
            ),
          ),
        ),
      ),
    );
  }
}

class _HoldChallenge extends StatelessWidget {
  const _HoldChallenge({
    required this.holding,
    required this.onStart,
    required this.onStop,
  });

  final bool holding;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.family_restroom_rounded, size: 72),
        const SizedBox(height: 24),
        Text(
          'Dành cho người lớn',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Nhấn và giữ nút bên dưới trong 3 giây.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Semantics(
          label: 'Nhấn giữ ba giây để tiếp tục',
          button: true,
          value: holding ? 'Đang giữ' : 'Chưa bắt đầu',
          child: Listener(
            onPointerDown: (_) => onStart(),
            onPointerUp: (_) => onStop(),
            onPointerCancel: (_) => onStop(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              constraints: const BoxConstraints(minWidth: 240, minHeight: 72),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: holding
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(holding ? Icons.hourglass_top_rounded : Icons.touch_app),
                  const SizedBox(width: 12),
                  Text(holding ? 'Tiếp tục giữ…' : 'Nhấn và giữ'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WrittenChallenge extends StatelessWidget {
  const _WrittenChallenge({required this.showRetry, required this.onAnswer});

  final bool showRetry;
  final ValueChanged<int> onAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Ba cộng bốn bằng bao nhiêu?',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (showRetry)
          Semantics(
            liveRegion: true,
            child: const Text('Chưa khớp. Vui lòng thử lại.'),
          ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            for (final answer in const [6, 7, 8])
              SizedBox(
                width: 96,
                height: 64,
                child: OutlinedButton(
                  onPressed: () => onAnswer(answer),
                  child: Text('$answer'),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
