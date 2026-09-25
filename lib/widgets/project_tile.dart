import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colors.primaryContainer,
          child: Icon(Icons.folder_outlined, color: colors.onPrimaryContainer),
        ),
        title: Text(project.title),
        subtitle: Text(
          project.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text('${project.year}'),
      ),
    );
  }
}