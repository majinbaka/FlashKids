import 'package:flutter/material.dart';

class LearningSettingsScreen extends StatefulWidget {
  const LearningSettingsScreen({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  State<LearningSettingsScreen> createState() => _LearningSettingsScreenState();
}

class _LearningSettingsScreenState extends State<LearningSettingsScreen> {
  bool _soundEnabled = true;
  bool _voiceEnabled = true;
  bool _gentleReminder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Quay lại tổng quan phụ huynh',
          onPressed: widget.onBack,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('Cài đặt học tập'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                SwitchListTile(
                  value: _soundEnabled,
                  onChanged: (value) => setState(() => _soundEnabled = value),
                  title: const Text('Âm thanh hướng dẫn'),
                  subtitle: const Text(
                    'Luôn có nội dung tương đương trên màn hình',
                  ),
                  secondary: const Icon(Icons.volume_up_rounded),
                ),
                SwitchListTile(
                  value: _voiceEnabled,
                  onChanged: (value) => setState(() => _voiceEnabled = value),
                  title: const Text('Hoạt động phát âm'),
                  subtitle: const Text(
                    'Bản prototype chưa dùng microphone thật',
                  ),
                  secondary: const Icon(Icons.mic_rounded),
                ),
                SwitchListTile(
                  value: _gentleReminder,
                  onChanged: (value) => setState(() => _gentleReminder = value),
                  title: const Text('Nhắc học nhẹ nhàng'),
                  subtitle: const Text('Thời gian nhắc sẽ được quyết định sau'),
                  secondary: const Icon(Icons.notifications_none_rounded),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: widget.onBack,
                  icon: const Icon(Icons.check_rounded),
                  label: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Lưu bản xem trước'),
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
