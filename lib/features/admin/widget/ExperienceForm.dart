import 'package:flutter/material.dart';

class ExperienceForm extends StatefulWidget {
  const ExperienceForm({super.key});

  @override
  State<ExperienceForm> createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<ExperienceForm> {
  bool _isCustom = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Experience'),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _tab('Custom', _isCustom, () => _isCustom = true),
            _tab('Organisation', !_isCustom, () => _isCustom = false),
          ],
        ),
        const SizedBox(height: 20),
        _input('Organisation name *'),
        const SizedBox(height: 16),
        _input('Organisation address'),
      ],
    );
  }

  Widget _tab(String text, bool active, VoidCallback onTap) => Expanded(
        child: GestureDetector(
          onTap: () => setState(onTap),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: active ? Colors.deepOrange : Colors.white,
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: active ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      );

  Widget _input(String label) => TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      );
}
