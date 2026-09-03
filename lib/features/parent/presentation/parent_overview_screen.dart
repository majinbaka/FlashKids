import 'package:flutter/material.dart';

class ParentOverviewScreen extends StatelessWidget {
  const ParentOverviewScreen({
    required this.onProgress,
    required this.onSettings,
    required this.onProfile,
    required this.onExit,
    super.key,
  });

  final VoidCallback onProgress;
  final VoidCallback onSettings;
  final VoidCallback onProfile;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khu vực phụ huynh'),
        actions: [
          TextButton.icon(
            onPressed: onExit,
            icon: const Icon(Icons.child_care_rounded),
            label: const Text('Về Kid Zone'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  'Tổng quan tuần này',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _SummaryCard(
                      label: 'Thời gian học',
                      value: '42 phút',
                      icon: Icons.schedule_rounded,
                    ),
                    _SummaryCard(
                      label: 'Hoạt động',
                      value: '8 lượt',
                      icon: Icons.school_rounded,
                    ),
                    _SummaryCard(
                      label: 'Từ đã luyện',
                      value: '16 từ',
                      icon: Icons.record_voice_over_rounded,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Quản lý',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _ParentDestination(
                  title: 'Tiến độ học tập',
                  subtitle: 'Xem kỹ năng và nội dung cần hỗ trợ',
                  icon: Icons.insights_rounded,
                  onTap: onProgress,
                ),
                _ParentDestination(
                  title: 'Cài đặt học tập',
                  subtitle: 'Âm thanh, giọng nói và nhắc học',
                  icon: Icons.tune_rounded,
                  onTap: onSettings,
                ),
                _ParentDestination(
                  title: 'Hồ sơ trẻ',
                  subtitle: 'Bản xem trước cho Phase 2',
                  icon: Icons.account_circle_rounded,
                  onTap: onProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 220),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ParentDestination extends StatelessWidget {
  const _ParentDestination({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        minTileHeight: 72,
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
