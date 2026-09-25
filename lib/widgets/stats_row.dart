import 'package:flutter/material.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatItem(label: 'Proyek', value: '12'),
        _StatItem(label: 'Pengikut', value: '1.2K'),
        _StatItem(label: 'Mengikuti', value: '340'),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(value, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: textTheme.bodySmall),
      ],
    );
  }
}