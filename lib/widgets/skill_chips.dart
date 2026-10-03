import 'package:flutter/material.dart';

class SkillChips extends StatelessWidget {
  const SkillChips({super.key, required this.skills});

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [for (final skill in skills) Chip(label: Text(skill))],
    );
  }
}