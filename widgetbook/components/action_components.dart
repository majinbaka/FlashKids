import 'package:flash_kids/app/presentation/large_action_button.dart';
import 'package:flutter/material.dart';

class ActionComponents extends StatelessWidget {
  const ActionComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: [
          LargeActionButton(
            label: 'Bắt đầu',
            icon: Icons.play_arrow_rounded,
            onPressed: () {},
          ),
          LargeActionButton(
            label: 'Về trang chủ',
            icon: Icons.home_rounded,
            onPressed: () {},
            filled: false,
          ),
          const LargeActionButton(
            label: 'Chưa sẵn sàng',
            icon: Icons.lock_rounded,
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
