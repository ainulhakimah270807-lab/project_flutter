import 'dart:io';
import 'package:flutter/material.dart';

ImageProvider getAvatarImageProvider(String pathOrUrl) {
  final trimmed = pathOrUrl.trim();
  if (trimmed.isEmpty) {
    return const NetworkImage('https://picsum.photos/200');
  }
  if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
    return NetworkImage(trimmed);
  }
  final file = File(trimmed);
  if (file.existsSync()) {
    return FileImage(file);
  }
  return const NetworkImage('https://picsum.photos/200');
}
