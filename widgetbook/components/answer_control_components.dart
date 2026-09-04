import 'package:flash_kids/app/presentation/kid_answer_control.dart';
import 'package:flutter/material.dart';

class AnswerControlComponents extends StatelessWidget {
  const AnswerControlComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          KidAnswerControl(
            state: const KidAnswerControlViewState(
              label: 'A',
              semanticsLabel: 'Chọn A',
            ),
            onPressed: () {},
          ),
          KidAnswerControl(
            state: const KidAnswerControlViewState(
              label: '5',
              semanticsLabel: 'Chọn đáp án 5',
            ),
            onPressed: () {},
            variant: KidAnswerControlVariant.prominent,
          ),
        ],
      ),
    );
  }
}
