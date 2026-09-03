import 'package:flutter/material.dart';

class ParentProgressScreen extends StatelessWidget {
  const ParentProgressScreen({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Quay lại tổng quan phụ huynh',
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('Tiến độ học tập'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  'Theo kỹ năng',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                const _ProgressRow(
                  label: 'Bảng chữ cái',
                  detail: 'Đang tiến bộ đều',
                  value: 0.72,
                ),
                const _ProgressRow(
                  label: 'Từ vựng',
                  detail: 'Cần luyện lại: bird, sheep',
                  value: 0.48,
                ),
                const _ProgressRow(
                  label: 'Toán trực quan',
                  detail: 'Đang làm quen phép trừ',
                  value: 0.38,
                ),
                const SizedBox(height: 32),
                Text(
                  'Nội dung cần hỗ trợ',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.record_voice_over_rounded),
                    title: Text('Âm /b/ và /p/'),
                    subtitle: Text('Đã thử lại nhiều lần trong tuần này'),
                  ),
                ),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.remove_circle_outline_rounded),
                    title: Text('Phép trừ trong phạm vi 5'),
                    subtitle: Text('Nên luyện bằng đồ vật trực quan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({
    required this.label,
    required this.detail,
    required this.value,
  });

  final String label;
  final String detail;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(detail),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: value),
          ],
        ),
      ),
    );
  }
}
