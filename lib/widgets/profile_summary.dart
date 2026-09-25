import 'package:flutter/material.dart';
import 'profile_header.dart';
import 'skill_chips.dart';
import 'stats_row.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProfileHeader(),
        SizedBox(height: 16),
        StatsRow(),
        SizedBox(height: 16),
        SkillChips(),
      ],
    );
  }
}