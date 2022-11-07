import 'package:app_listview/project_content.dart';
import 'package:app_listview/providers/project_list_provider.dart';
import 'package:flutter/cupertino.dart';

class ProjectLayout extends StatelessWidget {
  const ProjectLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ProjectContent(
            provider: projectsProvider, constraints: constraints);
      },
    );
  }
}
