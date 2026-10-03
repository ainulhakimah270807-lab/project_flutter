import 'package:flutter/material.dart';
import '../models/profile_data.dart';
import 'profile_header.dart';
import 'skill_chips.dart';
import 'stats_row.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key, required this.profile});

  final ProfileData profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileHeader(profile: profile),
        const SizedBox(height: 16),
        const StatsRow(),
        const SizedBox(height: 16),
        SkillChips(skills: profile.skills),
      ],
    );
  }
}