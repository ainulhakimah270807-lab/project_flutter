import 'package:flutter/material.dart';

class GalleryTile extends StatelessWidget {
  const GalleryTile({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        },
        errorBuilder: (context, error, stackTrace) => const ColoredBox(
          color: Colors.black12,
          child: Center(child: Icon(Icons.broken_image_outlined)),
        ),
      ),
    );
  }
}