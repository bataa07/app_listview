import 'package:app_listview/draggable_list_item.dart';
import 'package:app_listview/project_list/project_list.dart';
import 'package:app_listview/providers/project_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ListItem extends ConsumerStatefulWidget {
  const ListItem({
    super.key,
    required this.project,
    required this.index,
  });

  final Project project;
  final int index;

  @override
  ConsumerState<ListItem> createState() => _ListItemState();
}

class _ListItemState extends ConsumerState<ListItem> {
  late PageStorageKey pageStorageKey;

  @override
  void initState() {
    super.initState();

    pageStorageKey =
        PageStorageKey<String>('project${widget.project.hashCode}');
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.project.isParent) {
      return ListTile(
        minVerticalPadding: 0.0,
        onTap: () {},
        leading: Padding(
          padding: EdgeInsets.only(
            left: widget.project.parentId != null ? 32.0 : 0.0,
          ),
          child: Text('${widget.index} - ${widget.project.id.toString()}'),
        ),
        title: Text(widget.project.name),
      );
    }

    List<Project> subProjects = ref
        .read(projectsProvider.notifier)
        .items
        .where((item) => item.parentId == widget.project.id)
        .toList();

    return ExpansionTile(
      key: pageStorageKey,
      leading: Text('${widget.index} - ${widget.project.id.toString()}'),
      title: Text(widget.project.name),
      children: _subProjects(subProjects, widget.index),
    );
  }

  List<Widget> _subProjects(List<Project> subProjects, int index) {
    List<Widget> items = [];
    ValueKey visibilityKey = ValueKey('sub_item_key_$index');

    for (var subIndex = 0; subIndex < subProjects.length; subIndex++) {
      final subProject = subProjects[subIndex];
      GlobalKey itemKey = GlobalKey();

      int index = ref.read(projectsProvider.notifier).indexOf(subProject);

      items.add(
        DraggableListItem(
          index: index,
          project: subProject,
          itemKey: itemKey,
          provider: projectsProvider,
          child: ListItem(
            key: itemKey,
            project: subProject,
            index: index,
          ),
        ),
      );
    }

    items.add(
      VisibilityDetector(
        key: visibilityKey,
        onVisibilityChanged: (info) async {
          if (info.visibleFraction == 0) return;

          ref.read(projectsProvider.notifier).fetchNextData(widget.project);
        },
        // TODO:
        child: const Divider(height: 4),
      ),
    );

    return items;
  }
}
