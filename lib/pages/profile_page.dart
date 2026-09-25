import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../data/dummy_data.dart';
import '../widgets/contact_section.dart';
import '../widgets/gallery_tile.dart';
import '../widgets/profile_summary.dart';
import '../widgets/project_tile.dart';
import '../widgets/section_title.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Digital')),
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= Breakpoints.expanded) {
              return const _TwoPaneLayout();
            }
            return const _SinglePaneLayout();
          },
        ),
      ),
    );
  }
}

class _SinglePaneLayout extends StatelessWidget {
  const _SinglePaneLayout();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const SliverToBoxAdapter(child: ProfileSummary()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ..._contentSlivers(),
          _bottomSpacer(context),
        ],
      ),
    );
  }
}

class _TwoPaneLayout extends StatelessWidget {
  const _TwoPaneLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          width: 340,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: ProfileSummary(),
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