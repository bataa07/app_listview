import 'package:app_listview/draggable_list_item.dart';
import 'package:app_listview/list_item.dart';
import 'package:app_listview/pagination_state/pagination_state.dart';
import 'package:app_listview/project_list/project_list.dart';
import 'package:app_listview/providers/project_list_provider.dart';
import 'package:app_listview/shimmer/shimmer_loader.dart';
import 'package:app_listview/shimmer/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectContent extends StatefulHookConsumerWidget {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 10000),
        curve: Curves.ease,
      );
    });
  }

  void _scrollUp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 10000),
        curve: Curves.ease,
      );
    });
  }

  void _scrollCurrent() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double currentScroll = _scrollController.position.pixels;

      _scrollController.jumpTo(currentScroll);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);
    final orientation = useState<ScrollbarOrientation?>(null);

    useEffect(() {
      if (orientation.value == ScrollbarOrientation.bottom) {
        _scrollDown();
      } else if (orientation.value == ScrollbarOrientation.top) {
        _scrollUp();
      } else {
        _scrollCurrent();
      }

      return;
    }, [orientation.value]);

    return Listener(
      onPointerUp: (event) {
        orientation.value = null;
      },
      onPointerMove: (event) {
        final parentListMaxHeight = widget.constraints.maxHeight;
        final distance = event.localPosition.dy;

        if (distance > parentListMaxHeight * 0.8) {
          orientation.value = ScrollbarOrientation.bottom;
        } else if (distance < parentListMaxHeight * 0.2) {
          orientation.value = ScrollbarOrientation.top;
        } else {
          orientation.value = null;
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

                  if (projects.length - 5 <= index) {
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
