import 'package:flutter/material.dart';

import '../core/breakpoints.dart';
import '../data/dummy_data.dart';
import '../models/profile_data.dart';
import '../widgets/contact_section.dart';
import '../widgets/gallery_tile.dart';
import '../widgets/profile_summary.dart';
import '../widgets/project_tile.dart';
import '../widgets/section_title.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileData _profile = const ProfileData(
    name: 'Ainul Hakimah',
    email: 'ainulhakimah270807@gmail.com',
    phone: '081252611176',
    bio: 'Suka desain UI/UX, Travelling dan minum red velvet.',
    nim: 'E41252793',
    prodi: 'Teknik Informatika',
    universitas: 'Politeknik Negeri Jember',
    tahunMasuk: '2025',
    avatarUrl: 'https://picsum.photos/200',
    skills: ['UI/UX Design', 'Travelling', 'Red Velvet', 'PHP & Web'],
  );

  // Method untuk membuka halaman Edit Profil dan menerima data hasil perubahannya
  Future<void> _openEditPage() async {
    final result = await Navigator.push<ProfileData>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfilePage(initialData: _profile),
      ),
    );

    if (!mounted || result == null) return;

    setState(() => _profile = result);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil diperbarui ✅')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Digital')),
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= Breakpoints.expanded) {
              return _TwoPaneLayout(profile: _profile);
            }
            return _SinglePaneLayout(profile: _profile);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openEditPage,
        icon: const Icon(Icons.edit),
        label: const Text('Edit Profil'),
      ),
    );
  }
}

class _SinglePaneLayout extends StatelessWidget {
  const _SinglePaneLayout({required this.profile});

  final ProfileData profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          // Mengirim data dinamis _profile ke widget ProfileSummary (jika ProfileSummary menerimanya, 
          // atau pastikan ProfileSummary membaca dari data yang dikirim)
          SliverToBoxAdapter(child: ProfileSummary(profile: profile)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ..._contentSlivers(),
          _bottomSpacer(context),
        ],
      ),
    );
  }
}

class _TwoPaneLayout extends StatelessWidget {
  const _TwoPaneLayout({required this.profile});

  final ProfileData profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 340,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ProfileSummary(profile: profile),
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                ..._contentSlivers(),
                _bottomSpacer(context),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

List<Widget> _contentSlivers() {
  return [
    const SliverToBoxAdapter(child: SectionTitle('Proyek')),
    SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      sliver: SliverList.separated(
        itemCount: projects.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, i) => ProjectTile(project: projects[i]),
      ),
    ),
    const SliverToBoxAdapter(child: SizedBox(height: 12)),
    const SliverToBoxAdapter(child: SectionTitle('Galeri')),
    SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 160,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: galleryImages.length,
        itemBuilder: (context, i) => GalleryTile(url: galleryImages[i]),
      ),
    ),
    const SliverToBoxAdapter(child: SizedBox(height: 12)),
    const SliverToBoxAdapter(child: ContactSection()),
  ];
}

Widget _bottomSpacer(BuildContext context) {
  final bottomInset = MediaQuery.paddingOf(context).bottom;
  return SliverToBoxAdapter(child: SizedBox(height: bottomInset + 16));
}