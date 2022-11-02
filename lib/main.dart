import 'package:app_listview/pagination_state/pagination_state.dart';
import 'package:app_listview/project_list/project_list.dart';
import 'package:app_listview/providers/project_list_provider.dart';
import 'package:app_listview/shimmer/shimmer_loader.dart';
import 'package:app_listview/shimmer/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: Column(
      //         children: const [
      //           Expanded(child: ProjectContent1()),
      //           Divider(
      //             height: 16,
      //             color: Colors.amber,
      //           ),
      //           Expanded(child: ProjectContent1()),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      body: Column(
        children: <Widget>[
          ProjectContent(provider: projectsProvider1),
          Divider(
            height: 16,
            color: Colors.amber,
          ),
          ProjectContent(provider: projectsProvider2),
        ],
      ),
    );
  }
}

class ProjectContent extends ConsumerStatefulWidget {
  const ProjectContent({super.key, required this.provider});

  final StateNotifierProvider<PaginationNotifier<Project>,
      PaginationState<Project>> provider;

  @override
  ConsumerState<ProjectContent> createState() => _ProjectContentState();
}

class _ProjectContentState extends ConsumerState<ProjectContent> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double threshold = MediaQuery.of(context).size.height * 0.20;

      print('_scrollController.addListener');

      if (maxScroll - currentScroll <= threshold) {
        ref.read(widget.provider.notifier).fetchNextData();
      }
    });

    itemPositionsListener.itemPositions.addListener(() {
      var isLastPage = ref.read(widget.provider.notifier).isLastPage;

      if (isLastPage) return;

      var itemsLength = ref.read(widget.provider.notifier).itemsLength;
      var currentIndex = itemPositionsListener.itemPositions.value.last.index;
      var listLength = itemPositionsListener.itemPositions.value.length;

      if (listLength >= itemsLength) {
        ref.read(widget.provider.notifier).fetchNextData();

        return;
      }

      if (currentIndex >= itemsLength - 3) {
        ref.read(widget.provider.notifier).fetchNextData();

        return;
      }
    });
  }

  Project? tempProject;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);
    const pageStorageKey = PageStorageKey<String>('projects');

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          state.when(
            data: (projects) {
              return ListView.builder(
                key: pageStorageKey,
                shrinkWrap: true,
                // itemScrollController: itemScrollController,
                // itemPositionsListener: itemPositionsListener,

                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  GlobalKey itemKey = GlobalKey();

                  return Draggable<Project>(
                    data: project,
                    feedback: Opacity(
                      opacity: 0.8,
                      child: FeedbackWidget(
                        dragChildKey: itemKey,
                        child: ListTile(
                          minVerticalPadding: 0.0,
                          leading: Text(project.id.toString()),
                          title: Text(project.name),
                        ),
                      ),
                    ),
                    onDragStarted: () {
                      tempProject = project;
                      print('onDragStarted: ${tempProject?.toJson()}');
                      ref.read(widget.provider.notifier).removeAt(index);
                    },
                    onDraggableCanceled: (velocity, offset) {
                      print('onDraggableCanceled: ${tempProject?.toJson()}');
                      ref
                          .read(widget.provider.notifier)
                          .insert(index, tempProject!);
                    },
                    child: DragTarget<Project>(
                      builder: (context, candidates, rejects) {
                        return ListTile(
                          minVerticalPadding: 0.0,
                          key: itemKey,
                          onTap: () => print(project.toJson()),
                          leading: Text(project.id.toString()),
                          title: Text(project.name),
                        );
                      },
                      onWillAccept: (value) => true,
                      onAccept: (value) => ref
                          .read(widget.provider.notifier)
                          .insert(index, value),
                    ),
                  );
                },
              );
            },
            loading: () {
              return const ShimmerLoader(
                shimmerItem: Skeleton(),
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: Text(
                  error.toString(),
                ),
              );
            },
            onLoading: (projects) {
              return ListView.builder(
                key: pageStorageKey,
                shrinkWrap: true,
                // itemScrollController: itemScrollController,
                // itemPositionsListener: itemPositionsListener,

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

                  return ListTile(
                    minVerticalPadding: 0.0,
                    leading: Text(project.id.toString()),
                    title: Text(project.name),
                  );
                },
              );
            },
            onError: (projects, error, stackTrace) {
              return ListView.builder(
                key: pageStorageKey,
                shrinkWrap: true,
                // itemScrollController: itemScrollController,
                // itemPositionsListener: itemPositionsListener,

                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];

                  return ListTile(
                    minVerticalPadding: 0.0,
                    leading: Text(project.id.toString()),
                    title: Text(project.name),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    super.key,
    required this.dragChildKey,
    required this.child,
  });

  final GlobalKey dragChildKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final RenderBox renderBox =
        dragChildKey.currentContext?.findRenderObject() as RenderBox;

    final size = renderBox.size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Material(child: child),
    );
  }
}

class ListenPointer extends StatelessWidget {
  const ListenPointer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: child,
      onPointerMove: (PointerMoveEvent event) {
        print("x: ${event.position.dx}, y: ${event.position.dy}");
      },
    );
  }
}

class ProjectContent1 extends ConsumerStatefulWidget {
  const ProjectContent1({super.key});

  @override
  ConsumerState<ProjectContent1> createState() => _ProjectContent1State();
}

class _ProjectContent1State extends ConsumerState<ProjectContent1> {
  final PagingController<int, Project> _pagingController =
      PagingController(firstPageKey: 0);

  static const _pageSize = 10;
  Project? tempProject;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await ref.read(projectsProvider1.notifier).fetchData();
      final isLastPage = newItems.length < _pageSize;

      _pagingController.itemList;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => PagedListView<int, Project>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Project>(
          itemBuilder: (context, project, index) {
            GlobalKey itemKey = GlobalKey();

            return Draggable<Project>(
              data: project,
              feedback: Opacity(
                opacity: 0.8,
                child: FeedbackWidget(
                  dragChildKey: itemKey,
                  child: ListTile(
                    minVerticalPadding: 0.0,
                    leading: Text(project.id.toString()),
                    title: Text(project.name),
                  ),
                ),
              ),
              onDragStarted: () {
                tempProject = project;
                print('onDragStarted: ${tempProject?.toJson()}');
                ref.read(projectsProvider1.notifier).removeAt(index);
              },
              onDraggableCanceled: (velocity, offset) {
                print('onDraggableCanceled: ${tempProject?.toJson()}');
                ref
                    .read(projectsProvider1.notifier)
                    .insert(index, tempProject!);
              },
              child: DragTarget<Project>(
                builder: (context, candidates, rejects) {
                  return ListTile(
                    minVerticalPadding: 0.0,
                    key: itemKey,
                    onTap: () => print(project.toJson()),
                    leading: Text(project.id.toString()),
                    title: Text(project.name),
                  );
                },
                onWillAccept: (value) => true,
                onAccept: (value) {
                  print('onAccept: $value');
                  ref.read(projectsProvider1.notifier).insert(index, value);
                },
              ),
            );
          },
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
