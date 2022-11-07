import 'dart:async';
import 'dart:convert';

import 'package:app_listview/pagination_state/pagination_state.dart';
import 'package:app_listview/project_list/project_list.dart';
import 'package:faker/faker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedProjectProvider = StateProvider<Project?>((_) => null);

final idProvider = StateProvider<int>((_) => 0);

final projectsProvider = StateNotifierProvider<PaginationNotifier<Project>,
    PaginationState<Project>>(
  (ref) {
    int pageSize = 10;
    int totalRecords = 0;
    int employeeId = 0;

    return PaginationNotifier(
      pageSize: pageSize,
      totalRecords: totalRecords,
      fetchData: ([parentItem]) async => await _fetchData(
        employeeId,
        pageSize,
        ref,
        parentItem,
      ),
      mapToObject: (Map<String, dynamic> map) => Project.fromJson(map),
    )..init();
  },
);

class PaginationNotifier<T> extends StateNotifier<PaginationState<T>> {
  PaginationNotifier({
    required this.fetchData,
    required this.pageSize,
    required this.totalRecords,
    required this.mapToObject,
  }) : super(const PaginationState.loading());

  final T Function(Map<String, dynamic> map) mapToObject;
  final Future<List<T>> Function([T? parentItem]) fetchData;
  final int pageSize;
  final int totalRecords;

  final List<T> _items = [];

  bool isLastPage = false;
  int itemsLength = 0;

  void init() => _fetchInitialData();

  List<T> get items => _items;

  void _updateData(List<T> result, [T? parentItem]) {
    isLastPage = result.length < pageSize;
    List<T> items = [];

    if (parentItem != null) {
      Map<String, dynamic> parentItemMap = jsonDecode(jsonEncode(parentItem));

      int lastIndex = _items.lastIndexWhere((item) {
        Map<String, dynamic> mapItem = jsonDecode(jsonEncode(item));

        return mapItem['parentId'] == parentItemMap['id'];
      });

      int parentIndex = _items.indexOf(parentItem);

      if (lastIndex != -1) {
        items = _items..insertAll(lastIndex + 2, result);
      } else {
        items = _items..insertAll(parentIndex + 1, result);
      }
    } else {
      items = _items..addAll(result);
    }

    itemsLength = items.length;
    state = PaginationState.data(items);
  }

  int indexOf(T item) => _items.indexOf(item);

  void updateItem(T oldItem, T newItem) {
    int index = _items.indexWhere((item) => oldItem == item);

    if (index == -1) return;

    _items[index] = newItem;

    state = PaginationState.data(_items);
  }

  void reorderItem(int oldIndex, int newIndex, [T? newItem]) {
    T temp = newItem ?? _items[oldIndex];

    _items.removeAt(oldIndex);
    _items.insert(newIndex, temp);

    state = PaginationState.data(_items);
  }

  void removeAt(int index) {
    _items.removeAt(index);

    state = PaginationState.data(_items);
  }

  void remove(T item, {required bool isSubItem}) {
    if (isSubItem) {
      Map<String, dynamic> mapSubItem = jsonDecode(jsonEncode(item));

      T parentItem = _items.firstWhere((item) {
        Map<String, dynamic> mapItem = jsonDecode(jsonEncode(item));

        return mapItem['id'] == mapSubItem['parentId'];
      });
      int index = _items.indexWhere((item) => item == parentItem);

      Map<String, dynamic> parentMapItem = jsonDecode(jsonEncode(parentItem));
      List subProjects = parentMapItem['subProjects'];
      subProjects
          .removeWhere((subProject) => subProject['id'] == mapSubItem['id']);
      parentMapItem['subProjects'] = subProjects;

      T newParentItem = mapToObject(parentMapItem);

      _items[index] = newParentItem;
    } else {
      _items.remove(item);
    }

    state = PaginationState.data(_items);
  }

  void insert(int index, T item) {
    _items.insert(index, item);

    state = PaginationState.data(_items);
  }

  Future<void> _fetchInitialData() async {
    try {
      state = const PaginationState.loading();

      final List<T> result = await fetchData();

      _updateData(result);
    } catch (e, stk) {
      state = PaginationState.error(e, stk);
    }
  }

  bool isDataState() => state == PaginationState<T>.data(_items);

  Future<void> fetchNextData([T? parentItem]) async {
    print("fetchNextData");

    if (isLastPage) {
      print("isLastPage: $isLastPage");

      return;
    }

    if (state == PaginationState<T>.onLoading(_items)) {
      print("Rejected");

      return;
    }

    print("Fetching next batch of items");

    state = PaginationState.onLoading(_items);

    try {
      final result = await fetchData(parentItem);

      _updateData(result, parentItem);
    } catch (e, stk) {
      print("Error fetching next page, error: $e, stackTrace: $stk");

      state = PaginationState.onError(_items, e, stk);
    }
  }
}

Future<List<Project>> _fetchData(
  int employeeId,
  int pageSize,
  Ref ref,
  Project? parentItem,
) async {
  List<Project> value = [];

  await Future.delayed(const Duration(seconds: 1), () {
    value = List<Project>.generate(pageSize, (index) {
      bool isParent = parentItem != null
          ? false
          : Faker().randomGenerator.integer(100, min: 0) < 40;
      int id = ref.read(idProvider);

      Project project = Project(
        id: id,
        name: isParent ? Faker().vehicle.make() : Faker().vehicle.model(),
        budget: Faker().randomGenerator.integer(15000, min: 100),
        createdAt:
            Faker().date.dateTime(minYear: 1990, maxYear: 2022).toString(),
        currentStep: 0,
        description: Faker().lorem.sentence(),
        members: [],
        organizationId: 1,
        progress: Faker().randomGenerator.integer(100, min: 0) as double,
        startDate: Faker().date.dateTime(minYear: 1990, maxYear: 2022),
        status: 0,
        isParent: isParent,
        parentId: parentItem?.id,
      );

      ref.read(idProvider.notifier).state += 1;

      return project;
    });
  });

  print('fetch data ${parentItem?.id}');

  return value;
}
