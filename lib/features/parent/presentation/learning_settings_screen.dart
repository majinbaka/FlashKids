import 'package:flutter/material.dart';

enum FontSizePreference { standard, large }

enum AccountPlan { basic, family }

@immutable
class ChildAccountSummary {
  const ChildAccountSummary({
    required this.id,
    required this.name,
    required this.ageBand,
  });

  final String id;
  final String name;
  final String ageBand;
}

@immutable
class LearningSettingsViewState {
  const LearningSettingsViewState({
    required this.children,
    required this.selectedChildId,
    required this.fontSize,
    required this.accountPlan,
    required this.soundEnabled,
    required this.voiceEnabled,
    required this.gentleReminder,
  });

  final List<ChildAccountSummary> children;
  final String selectedChildId;
  final FontSizePreference fontSize;
  final AccountPlan accountPlan;
  final bool soundEnabled;
  final bool voiceEnabled;
  final bool gentleReminder;

  ChildAccountSummary get selectedChild =>
      children.firstWhere((child) => child.id == selectedChildId);

  LearningSettingsViewState copyWith({
    String? selectedChildId,
    FontSizePreference? fontSize,
    AccountPlan? accountPlan,
    bool? soundEnabled,
    bool? voiceEnabled,
    bool? gentleReminder,
  }) {
    return LearningSettingsViewState(
      children: children,
      selectedChildId: selectedChildId ?? this.selectedChildId,
      fontSize: fontSize ?? this.fontSize,
      accountPlan: accountPlan ?? this.accountPlan,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      voiceEnabled: voiceEnabled ?? this.voiceEnabled,
      gentleReminder: gentleReminder ?? this.gentleReminder,
    );
  }
}

class LearningSettingsScreen extends StatelessWidget {
  const LearningSettingsScreen({
    required this.state,
    required this.onChanged,
    required this.onBack,
    super.key,
  });

  final LearningSettingsViewState state;
  final ValueChanged<LearningSettingsViewState> onChanged;
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
        title: const Text('Cài đặt'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _SectionTitle(title: 'Tài khoản đang dùng'),
                const SizedBox(height: 8),
                RadioGroup<String>(
                  groupValue: state.selectedChildId,
                  onChanged: (value) =>
                      onChanged(state.copyWith(selectedChildId: value)),
                  child: Column(
                    children: [
                      for (final child in state.children)
                        Card(
                          child: RadioListTile<String>(
                            value: child.id,
                            title: Text(child.name),
                            subtitle: Text('Hồ sơ trẻ · ${child.ageBand}'),
                            secondary: const Icon(Icons.child_care_rounded),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _SectionTitle(title: 'Hiển thị'),
                const SizedBox(height: 8),
                Card(
                  child: DropdownButtonFormField<FontSizePreference>(
                    key: const Key('font-size-setting'),
                    initialValue: state.fontSize,
                    decoration: const InputDecoration(
                      labelText: 'Cỡ chữ',
                      prefixIcon: Icon(Icons.format_size_rounded),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: FontSizePreference.standard,
                        child: Text('Tiêu chuẩn'),
                      ),
                      DropdownMenuItem(
                        value: FontSizePreference.large,
                        child: Text('Lớn, dễ đọc'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        onChanged(state.copyWith(fontSize: value));
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),
                _SectionTitle(title: 'Loại tài khoản'),
                const SizedBox(height: 8),
                Card(
                  child: DropdownButtonFormField<AccountPlan>(
                    key: const Key('account-plan-setting'),
                    initialValue: state.accountPlan,
                    decoration: const InputDecoration(
                      labelText: 'Gói sử dụng',
                      prefixIcon: Icon(Icons.family_restroom_rounded),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: AccountPlan.basic,
                        child: Text('Cơ bản'),
                      ),
                      DropdownMenuItem(
                        value: AccountPlan.family,
                        child: Text('Gia đình'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        onChanged(state.copyWith(accountPlan: value));
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),
                _SectionTitle(title: 'Âm thanh và nhắc học'),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: state.soundEnabled,
                        onChanged: (value) =>
                            onChanged(state.copyWith(soundEnabled: value)),
                        title: const Text('Âm thanh hướng dẫn'),
                        subtitle: const Text(
                          'Luôn có nội dung tương đương trên màn hình',
                        ),
                        secondary: const Icon(Icons.volume_up_rounded),
                      ),
                      SwitchListTile(
                        value: state.voiceEnabled,
                        onChanged: (value) =>
                            onChanged(state.copyWith(voiceEnabled: value)),
                        title: const Text('Hoạt động phát âm'),
                        subtitle: const Text(
                          'Bản prototype chưa dùng microphone thật',
                        ),
                        secondary: const Icon(Icons.mic_rounded),
                      ),
                      SwitchListTile(
                        value: state.gentleReminder,
                        onChanged: (value) =>
                            onChanged(state.copyWith(gentleReminder: value)),
                        title: const Text('Nhắc học nhẹ nhàng'),
                        subtitle: const Text(
                          'Thời gian nhắc sẽ được quyết định sau',
                        ),
                        secondary: const Icon(Icons.notifications_none_rounded),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: onBack,
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
