import 'package:app_listview/draggable_list_item.dart';
import 'package:app_listview/list_item.dart';
import 'package:app_listview/pagination_state/pagination_state.dart';
import 'package:app_listview/project_list/project_list.dart';
import 'package:app_listview/providers/project_list_provider.dart';
import 'package:app_listview/shimmer/shimmer_loader.dart';
import 'package:app_listview/shimmer/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectContent extends ConsumerStatefulWidget {
  const ProjectContent(
      {super.key, required this.provider, required this.constraints});

  final StateNotifierProvider<PaginationNotifier<Project>,
      PaginationState<Project>> provider;
  final BoxConstraints constraints;

  @override
  ConsumerState<ProjectContent> createState() => _ProjectContentState();
}

class _ProjectContentState extends ConsumerState<ProjectContent> {
  final ScrollController _scrollController = ScrollController();
  final _pageKey = const PageStorageKey<String>('projects');

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 60),
      curve: Curves.linear,
    );
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  void _scrollUp() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 10),
      curve: Curves.fastOutSlowIn,
    );
    var to = _scrollController.offset - 3;
    to = (to < 0) ? 0 : to;
    _scrollController.jumpTo(to);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    return Listener(
      onPointerMove: (event) {
        final parentListMaxHeight = widget.constraints.maxHeight;
        final distance = event.localPosition.dy;

        print('parentListMinHeight: $parentListMaxHeight, distance: $distance');

        if (distance > parentListMaxHeight * 0.8) {
          _scrollDown();
        } else if (distance < parentListMaxHeight * 0.2) {
          _scrollUp();
        }
      },
      child: state.when(
        data: (projects) {
          return ListView.builder(
            key: _pageKey,
            controller: _scrollController,
            itemCount: projects.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final project = projects[index];
              GlobalKey itemKey = GlobalKey();
              ValueKey visibilityKey = ValueKey('item_key_${project.name}');

              if (project.parentId != null) return const SizedBox.shrink();

              return VisibilityDetector(
                key: visibilityKey,
                onVisibilityChanged: (VisibilityInfo info) {
                  if (info.visibleFraction == 0) return;

                  if (projects.length - 3 <= index) {
                    ref.read(widget.provider.notifier).fetchNextData();
                  }
                },
                child: DraggableListItem(
                  parentConstraint: widget.constraints,
                  index: index,
                  project: project,
                  itemKey: itemKey,
                  provider: widget.provider,
                  child: ListItem(
                    key: itemKey,
                    parentConstraint: widget.constraints,
                    project: project,
                    index: index,
                  ),
                ),
              );
            },
          );
        },
        loading: () => const ShimmerLoader(shimmerItem: Skeleton()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        onLoading: (projects, selectedIndex) {
          return ListView.builder(
            key: _pageKey,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: projects.length + 10,
            itemBuilder: (context, index) {
              if (selectedIndex! < index && selectedIndex + 10 >= index) {
                return const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Skeleton(),
                );
              }

              final project = projects[index];

              if (project.parentId != null) return const SizedBox.shrink();

              GlobalKey itemKey = GlobalKey();

              return DraggableListItem(
                parentConstraint: widget.constraints,
                index: index,
                project: project,
                itemKey: itemKey,
                provider: widget.provider,
                child: ListItem(
                  key: itemKey,
                  project: project,
                  index: index,
                ),
              );
            },
          );
        },
        onError: (projects, error, stackTrace) {
          return ListView.builder(
            key: _pageKey,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];

              if (project.parentId != null) return const SizedBox.shrink();

              return ListItem(
                project: project,
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
