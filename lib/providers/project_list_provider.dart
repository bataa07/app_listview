import 'dart:async';

import 'package:app_listview/pagination_state/pagination_state.dart';
import 'package:app_listview/project_list/project_list.dart';
import 'package:app_listview/project_member/project_member.dart';
import 'package:faker/faker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedProjectProvider = StateProvider<Project?>((_) => null);

final projectsProvider = StateNotifierProvider<PaginationNotifier<Project>,
    PaginationState<Project>>((ref) {
  int pageSize = 10;
  int totalRecords = 0;
  int id = 0;
  int employeeId = 0;

  return PaginationNotifier(
    pageSize: pageSize,
    totalRecords: totalRecords,
    fetchData: () async => await _fetchData(id, employeeId, pageSize),
  )..init();
});

Future<List<Project>> _fetchData(int id, int employeeId, int pageSize) async {
  List<Project> value = [];

  await Future.delayed(const Duration(seconds: 1), () {
    value = List<Project>.generate(pageSize, (index) {
      id += 1;

      bool isParent = Faker().randomGenerator.integer(100, min: 0) < 20;
      List<Project> subProjects = [];
      if (isParent) {
        int subProjectCount = Faker().randomGenerator.integer(5, min: 1);

        for (var i = 0; i < subProjectCount; i++) {
          subProjects.add(
            Project(
              id: id,
              name: Faker().vehicle.model(),
              budget: Faker().randomGenerator.integer(15000, min: 100),
              createdAt: Faker()
                  .date
                  .dateTime(minYear: 1990, maxYear: 2022)
                  .toString(),
              currentStep: 0,
              description: Faker().lorem.sentence(),
              members: [],
              organizationId: 1,
              progress: Faker().randomGenerator.integer(100, min: 0) as double,
              startDate: Faker().date.dateTime(minYear: 1990, maxYear: 2022),
              status: 0,
              isParent: false,
              subProjects: [],
            ),
          );
        }
      }

      int memberCount = Faker().randomGenerator.integer(5, min: 0);

      List<ProjectMember> members = [];

      for (var i = 0; i < memberCount; i++) {
        members.add(
          ProjectMember(
            avatarUrl: null,
            employeeId: employeeId,
            nickname: Faker().person.name(),
            role: 1,
            cost: 0.5,
          ),
        );
      }

      return Project(
        id: id,
        name: isParent ? Faker().vehicle.make() : Faker().vehicle.model(),
        budget: Faker().randomGenerator.integer(15000, min: 100),
        createdAt:
            Faker().date.dateTime(minYear: 1990, maxYear: 2022).toString(),
        currentStep: 0,
        description: Faker().lorem.sentence(),
        members: members,
        organizationId: 1,
        progress: Faker().randomGenerator.integer(100, min: 0) as double,
        startDate: Faker().date.dateTime(minYear: 1990, maxYear: 2022),
        status: 0,
        isParent: isParent,
        subProjects: subProjects,
      );
    });
  });

  print('fetch data');

  return value;
}

class PaginationNotifier<T> extends StateNotifier<PaginationState<T>> {
  PaginationNotifier({
    required this.fetchData,
    required this.pageSize,
    required this.totalRecords,
  }) : super(const PaginationState.loading());

  final Future<List<T>> Function() fetchData;
  final int pageSize;
  final int totalRecords;

  final List<T> _items = [];

  bool isLastPage = false;
  int itemsLength = 0;

  void init() => fetchInitialData();

  List<T> get items => _items;

  void updateData(List<T> result) {
    isLastPage = result.length < pageSize;
    var items = _items..addAll(result);

    itemsLength = items.length;
    state = PaginationState.data(items);
  }

  void reorderItem(int oldIndex, int newIndex) {
    T temp = _items[oldIndex];
    _items.removeAt(oldIndex);
    _items.insert(newIndex, temp);

    state = PaginationState.data(_items);
  }

  void removeAt(int index) {
    _items.removeAt(index);

    state = PaginationState.data(_items);
  }

  void insert(int index, T item) {
    _items.insert(index, item);

    state = PaginationState.data(_items);
  }

  Future<void> fetchInitialData() async {
    try {
      state = const PaginationState.loading();

      final List<T> result = await fetchData();

      updateData(result);
    } catch (e, stk) {
      state = PaginationState.error(e, stk);
    }
  }

  bool isDataState() => state == PaginationState<T>.data(_items);

  Future<void> fetchNextData() async {
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
      final result = await fetchData();

      print(result.length.toString());

      updateData(result);
    } catch (e, stk) {
      print("Error fetching next page, error: $e, stackTrace: $stk");

      state = PaginationState.onError(_items, e, stk);
    }
  }
}
