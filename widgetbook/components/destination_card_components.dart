import 'package:flash_kids/app/presentation/kid_destination_card.dart';
import 'package:flutter/material.dart';

class DestinationCardComponents extends StatelessWidget {
  const DestinationCardComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          KidDestinationCard(
            state: const KidDestinationCardViewState(
              label: 'Chữ cái',
              detail: 'A, B, C',
              icon: Icons.abc_rounded,
              semanticsLabel: 'Chữ cái. A, B, C',
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          KidDestinationCard(
            state: const KidDestinationCardViewState(
              label: 'Nghe và chọn',
              detail: 'Từ vựng',
              icon: Icons.hearing_rounded,
              semanticsLabel: 'Nghe và chọn. Kỹ năng Từ vựng',
            ),
            onPressed: () {},
            variant: KidDestinationCardVariant.prominent,
          ),
          const SizedBox(height: 16),
          KidDestinationCard(
            state: const KidDestinationCardViewState(
              label: 'Nhìn và nghe',
              detail: 'Làm quen bằng hình ảnh',
              icon: Icons.visibility_rounded,
              semanticsLabel: 'Nhìn và nghe. Làm quen bằng hình ảnh',
            ),
            onPressed: () {},
            variant: KidDestinationCardVariant.horizontal,
          ),
        ],
      ),
    );
  }
}
