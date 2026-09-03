import 'package:flash_kids/app/presentation/large_action_button.dart';
import 'package:flutter/material.dart';

@immutable
class ChildOnboardingResult {
  const ChildOnboardingResult({required this.name, required this.ageBand});

  final String name;
  final String ageBand;
}

class ChildOnboardingScreen extends StatefulWidget {
  const ChildOnboardingScreen({required this.onComplete, super.key});

  final ValueChanged<ChildOnboardingResult> onComplete;

  @override
  State<ChildOnboardingScreen> createState() => _ChildOnboardingScreenState();
}

class _ChildOnboardingScreenState extends State<ChildOnboardingScreen> {
  static const _ageBands = ['3–5 tuổi', '6–7 tuổi', '8–10 tuổi'];
  final _nameController = TextEditingController();
  var _step = _OnboardingStep.name;
  String? _selectedAgeBand;
  bool _showNameError = false;
  bool _showAgeError = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _continueFromName() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _showNameError = true);
      return;
    }
    setState(() => _step = _OnboardingStep.ageBand);
  }

  void _submitAgeBand() {
    if (_selectedAgeBand == null) {
      setState(() => _showAgeError = true);
      return;
    }
    widget.onComplete(
      ChildOnboardingResult(
        name: _nameController.text.trim(),
        ageBand: _selectedAgeBand!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ExcludeSemantics(
                    child: Image.asset(
                      'assets/images/mascots/mascot-idle.png',
                      height: 160,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _step == _OnboardingStep.name
                        ? 'Bé tên là gì nhỉ?'
                        : 'Bé thuộc khoảng tuổi nào?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _step == _OnboardingStep.name
                        ? 'Phụ huynh hãy nhập tên bé trước nhé.'
                        : 'Chọn một khoảng tuổi để xem bài học phù hợp.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  if (_step == _OnboardingStep.name)
                    _NameStep(
                      controller: _nameController,
                      showError: _showNameError,
                      onChanged: () {
                        if (_showNameError) {
                          setState(() => _showNameError = false);
                        }
                      },
                      onContinue: _continueFromName,
                    )
                  else
                    _AgeBandStep(
                      ageBands: _ageBands,
                      selectedAgeBand: _selectedAgeBand,
                      showError: _showAgeError,
                      onSelected: (ageBand) => setState(() {
                        _selectedAgeBand = ageBand;
                        _showAgeError = false;
                      }),
                      onBack: () =>
                          setState(() => _step = _OnboardingStep.name),
                      onComplete: _submitAgeBand,
                    ),
                  const SizedBox(height: 16),
                  Text(
                    'Thông tin này chỉ dùng trong phiên xem trước này.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
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

enum _OnboardingStep { name, ageBand }

class _NameStep extends StatelessWidget {
  const _NameStep({
    required this.controller,
    required this.showError,
    required this.onChanged,
    required this.onContinue,
  });

  final TextEditingController controller;
  final bool showError;
  final VoidCallback onChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => onContinue(),
          decoration: InputDecoration(
            labelText: 'Tên của bé',
            prefixIcon: const Icon(Icons.child_care_rounded),
            border: const OutlineInputBorder(),
            errorText: showError ? 'Hãy nhập tên của bé' : null,
          ),
          onChanged: (_) => onChanged(),
        ),
        const SizedBox(height: 24),
        LargeActionButton(
          label: 'Tiếp tục',
          icon: Icons.arrow_forward_rounded,
          onPressed: onContinue,
        ),
      ],
    );
  }
}

class _AgeBandStep extends StatelessWidget {
  const _AgeBandStep({
    required this.ageBands,
    required this.selectedAgeBand,
    required this.showError,
    required this.onSelected,
    required this.onBack,
    required this.onComplete,
  });

  final List<String> ageBands;
  final String? selectedAgeBand;
  final bool showError;
  final ValueChanged<String> onSelected;
  final VoidCallback onBack;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final ageBand in ageBands) ...[
          SizedBox(
            width: double.infinity,
            child: ChoiceChip(
              label: Text(ageBand),
              selected: selectedAgeBand == ageBand,
              onSelected: (_) => onSelected(ageBand),
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (showError)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Hãy chọn khoảng tuổi của bé',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        const SizedBox(height: 24),
        LargeActionButton(
          label: 'Xem bài học phù hợp',
          icon: Icons.auto_awesome_rounded,
          onPressed: onComplete,
        ),
        TextButton.icon(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_rounded),
          label: const Text('Đổi tên bé'),
        ),
      ],
    );
  }
}
