import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 480;

        final avatar = CircleAvatar(
          radius: isWide ? 56 : 48,
          backgroundImage: const NetworkImage('https://picsum.photos/seed/profile/300/300'),
        );

        if (isWide) {
          return Row(
            children: [
              avatar,
              const SizedBox(width: 20),
              const Expanded(child: _ProfileInfo(centered: false)),
            ],
          );
        }

        return Column(
          children: [
            avatar,
            const SizedBox(height: 12),
            const _ProfileInfo(centered: true),
          ],
        );
      },
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({required this.centered});

  final bool centered;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text('Fakhry', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text('Mobile Developer • Software Engineer', style: textTheme.bodyMedium),
        const SizedBox(height: 8),
        Text(
          'Suka membangun aplikasi Flutter dan belajar hal baru setiap hari.',
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}