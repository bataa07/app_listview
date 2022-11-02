import 'package:app_listview/pagination_state/pagination_state.dart';
import 'package:app_listview/project_list/project_list.dart';
import 'package:app_listview/providers/project_list_provider.dart';
import 'package:app_listview/shimmer/shimmer_loader.dart';
import 'package:app_listview/shimmer/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      body: ProjectContent(provider: projectsProvider),
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double threshold = MediaQuery.of(context).size.height * 0.20;

      if (maxScroll - currentScroll <= threshold) {
        ref.read(widget.provider.notifier).fetchNextData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);
    const pageStorageKey = PageStorageKey<String>('projects');

    ref.listen(widget.provider, (_, state) {
      if (ref.read(widget.provider.notifier).isDataState()) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (_scrollController.position.maxScrollExtent <= 0) {
            ref.read(widget.provider.notifier).fetchNextData();
          }
        });
      }
    });

    return state.when(
      data: (projects) {
        return ReorderableListView.builder(
          buildDefaultDragHandles: false,
          key: pageStorageKey,
          scrollController: _scrollController,
          itemCount: projects.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final project = projects[index];
            GlobalKey itemKey = GlobalKey();

            return ReorderableDragStartListener(
              key: itemKey,
              index: index,
              child: ListTile(
                minVerticalPadding: 0.0,
                onTap: () => print(project.toJson()),
                leading: Text(project.id.toString()),
                title: Text(project.name),
              ),
            );
          },
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            ref.read(widget.provider.notifier).reorderItem(oldIndex, newIndex);
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
          controller: _scrollController,
          itemCount: projects.length + 10,
          itemBuilder: (context, index) {
            if (index >= projects.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
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
          controller: _scrollController,
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
