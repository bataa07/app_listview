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
  const ProjectContent({super.key, required this.provider});

  final StateNotifierProvider<PaginationNotifier<Project>,
      PaginationState<Project>> provider;

  @override
  ConsumerState<ProjectContent> createState() => _ProjectContentState();
}

class _ProjectContentState extends ConsumerState<ProjectContent> {
  final ScrollController _scrollController = ScrollController();
  final _pageKey = const PageStorageKey<String>('projects');

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    return state.when(
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
                  index: index,
                  project: project,
                  itemKey: itemKey,
                  provider: widget.provider,
                  child: ListItem(
                    key: itemKey,
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
        onLoading: (projects) {
          return ListView.builder(
            key: _pageKey,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: projects.length + 10,
            itemBuilder: (context, index) {
              if (index >= projects.length) {
                return const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Skeleton(),
                );
              }

              final project = projects[index];

              if (project.parentId != null) return const SizedBox.shrink();

              return ListItem(
                project: project,
                index: index,
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
        });
  }
}
