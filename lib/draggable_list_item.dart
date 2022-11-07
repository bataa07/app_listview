import 'package:app_listview/feedback_widget.dart';
import 'package:app_listview/pagination_state/pagination_state.dart';
import 'package:app_listview/project_list/project_list.dart';
import 'package:app_listview/providers/project_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DraggableListItem extends HookConsumerWidget {
  const DraggableListItem({
    super.key,
    required this.project,
    required this.itemKey,
    required this.provider,
    required this.index,
    required this.child,
  });

  final int index;
  final Project project;
  final GlobalKey<State<StatefulWidget>> itemKey;
  final StateNotifierProvider<PaginationNotifier<Project>,
      PaginationState<Project>> provider;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTop = useState<bool>(true);
    final isSub = useState<bool>(false);
    final tempProject = useState<Project?>(null);

    return Draggable<Project>(
      data: project,
      feedback: Opacity(
        opacity: 0.8,
        child: FeedbackWidget(
          dragChildKey: itemKey,
          child: child,
        ),
      ),
      childWhenDragging: const SizedBox.shrink(),
      onDragStarted: () {
        tempProject.value = project;
      },
      onDragUpdate: (details) {
        final box = context.findAncestorRenderObjectOfType() as RenderBox;
        print(box.size);

        // print(details.delta);
        // print(details.globalPosition);
      },
      onDragCompleted: () {
        ref.read(provider.notifier).removeAt(index);
      },
      onDraggableCanceled: (velocity, offset) =>
          ref.read(provider.notifier).insert(index, tempProject.value!),
      child: DragTarget<Project>(
        builder: (context, candidates, rejects) {
          if (candidates.isNotEmpty) {
            var divider = Divider(
              color: Colors.red,
              height: 4.0,
              indent: isSub.value ? 32.0 : 0.0,
            );

            return Column(
              children: [
                isTop.value ? divider : const SizedBox.shrink(),
                child,
                !isTop.value ? divider : const SizedBox.shrink(),
              ],
            );
          }

          return child;
        },
        onWillAccept: (value) => true,
        onMove: (details) {
          final RenderBox renderBox =
              itemKey.currentContext?.findRenderObject() as RenderBox;

          final startY = renderBox.localToGlobal(Offset.zero).dy;
          final height = renderBox.size.height;
          final thresholdY = startY + height / 4;

          final startX = renderBox.localToGlobal(Offset.zero).dx;
          final widht = renderBox.size.width;
          final thresholdX = startX + widht * 0.1;

          if (details.offset.dy < thresholdY) {
            isTop.value = true;
          } else {
            isTop.value = false;
          }

          if (details.offset.dx < thresholdX) {
            isSub.value = false;
          } else {
            isSub.value = true;
          }
        },
        onAccept: (value) {
          var newIndex = isTop.value ? index : index + 1;

          var item = ref.read(projectsProvider.notifier).items[newIndex];

          Project tempProject = value.copyWith(parentId: item.parentId);

          ref.read(provider.notifier).insert(newIndex, tempProject);
        },
      ),
    );
  }
}
