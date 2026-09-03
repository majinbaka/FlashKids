import 'package:flutter/material.dart';

class ChildProfileScreen extends StatelessWidget {
  const ChildProfileScreen({required this.onBack, super.key});

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
        title: const Text('Hồ sơ trẻ'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.account_circle_rounded, size: 96),
                  const SizedBox(height: 24),
                  TextFormField(
                    initialValue: 'Bạn nhỏ',
                    decoration: const InputDecoration(
                      labelText: 'Tên hiển thị',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: '5–7 tuổi',
                    decoration: const InputDecoration(
                      labelText: 'Nhóm tuổi',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: '3–4 tuổi',
                        child: Text('3–4 tuổi'),
                      ),
                      DropdownMenuItem(
                        value: '5–7 tuổi',
                        child: Text('5–7 tuổi'),
                      ),
                      DropdownMenuItem(
                        value: '8–10 tuổi',
                        child: Text('8–10 tuổi'),
                      ),
                    ],
                    onChanged: (_) {},
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
                  const SizedBox(height: 12),
                  const Text(
                    'Đây là màn hình định hướng Phase 2; dữ liệu không được lưu.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
