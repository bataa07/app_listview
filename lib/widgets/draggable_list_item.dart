import 'package:app_listview/models/list_item.dart';
import 'package:app_listview/notifier/list_item_notifier.dart';
import 'package:app_listview/widgets/feedback_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DraggableListItem extends ConsumerStatefulWidget {
  const DraggableListItem({
    super.key,
    required this.item,
    required this.itemKey,
    required this.notifier,
    required this.index,
    required this.child,
    this.parentItem,
  });

  final int index;
  final ListItem item;
  final ListItem? parentItem;
  final GlobalKey<State<StatefulWidget>> itemKey;
  final ListItemNotifier notifier;
  final Widget child;

  @override
  ConsumerState<DraggableListItem> createState() => _DraggableListItemState();
}

class _DraggableListItemState extends ConsumerState<DraggableListItem> {
  ValueNotifier<bool> isTop = ValueNotifier<bool>(false);
  bool isSub = false;

  @override
  Widget build(BuildContext context) {
    return Draggable<ListItem>(
      data: widget.item,
      feedback: Opacity(
        opacity: 0.8,
        child: FeedbackWidget(
          dragChildKey: widget.itemKey,
          child: widget.child,
        ),
      ),
      childWhenDragging: const SizedBox.shrink(),
      onDragStarted: () {
        widget.notifier.oldParentItem = widget.parentItem;
        widget.notifier.oldIndex = widget.index;
      },
      child: DragTarget(
        builder: (context, candidates, rejects) {
          if (candidates.isNotEmpty) {
            return ValueListenableBuilder<bool>(
                valueListenable: isTop,
                builder: (context, value, child) {
                  return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: value
                              ? const BorderSide(color: Colors.red)
                              : BorderSide.none,
                          bottom: !value
                              ? const BorderSide(color: Colors.red)
                              : BorderSide.none,
                        ),
                      ),
                      child: widget.child);
                });
          }

          return widget.child;
        },
        onWillAccept: (value) => true,
        onMove: (details) {
          final RenderBox renderBox =
              widget.itemKey.currentContext?.findRenderObject() as RenderBox;

          final startY = renderBox.localToGlobal(Offset.zero).dy;
          final height = renderBox.size.height;
          final thresholdY = startY + height * 0.2;

          final startX = renderBox.localToGlobal(Offset.zero).dx;
          final widht = renderBox.size.width;
          final thresholdX = startX + widht * 0.1;

          if (details.offset.dy < thresholdY) {
            isTop.value = true;
          } else {
            isTop.value = false;
          }

          if (details.offset.dx < thresholdX) {
            isSub = false;
          } else {
            isSub = true;
          }
        },
        onAccept: (ListItem draggedIndex) {
          widget.notifier.reOrder(
            newParentItem: widget.parentItem,
            newIndex: widget.index,
          );
        },
      ),
    );
  }
}
