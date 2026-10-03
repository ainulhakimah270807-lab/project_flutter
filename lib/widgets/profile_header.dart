import 'package:flutter/material.dart';
import '../models/profile_data.dart';
import '../utils/avatar_helper.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profile});

  final ProfileData profile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 480;

        final avatar = CircleAvatar(
          radius: isWide ? 56 : 48,
          backgroundColor: Colors.blue.shade100,
          backgroundImage: getAvatarImageProvider(profile.avatarUrl),
          onBackgroundImageError: (exception, stackTrace) {},
        );

        if (isWide) {
          return Row(
            children: [
              avatar,
              const SizedBox(width: 20),
              Expanded(child: _ProfileInfo(profile: profile, centered: false)),
            ],
          );
        }

        return Column(
          children: [
            avatar,
            const SizedBox(height: 12),
            _ProfileInfo(profile: profile, centered: true),
          ],
        );
      },
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({required this.profile, required this.centered});

  final ProfileData profile;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(profile.name, style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text('${profile.prodi} • ${profile.universitas}', style: textTheme.bodyMedium),
        const SizedBox(height: 8),
        Text(
          profile.bio,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}