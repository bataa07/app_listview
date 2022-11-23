import 'package:app_listview/models/list_item.dart';
import 'package:flutter/material.dart';

enum StateType {
  data,
  loading,
  error,
  onLoading,
  onError,
}

class ListItemNotifier extends ChangeNotifier {
  ListItemNotifier({
    this.pageSize = 2,
    this.pagination = 1,
    this.totalRecords = 0,
    required this.fetchData,
  });

  int pageSize;
  int pagination;
  int totalRecords;

  final Future<List<ListItem>> Function(
    int pagination,
    int pageSize,
    int totalRecords, [
    ListItem? parentItem,
  ]) fetchData;

  StateType stateType = StateType.loading;

  final Map<int, ListItem> _items = {};
  final List<int> _orderList = [];

  ListItem? oldParentItem;
  int? oldIndex;

  void init() => _fetchInitialData();

  Future<void> _fetchInitialData() async {
    stateType = StateType.loading;

    final result = await fetchData(
      pagination,
      pageSize,
      totalRecords,
    );

    pagination += 1;

    _items.putIfAbsent(-1, () => ListItem.indicator());
    _orderList.add(-1);

    _updateData(result);

    notifyListeners();
  }

  Future<void> fetchNextData([ListItem? parentItem]) async {
    if (stateType == StateType.onLoading) {
      print('Reject');

      return;
    }

    stateType = StateType.onLoading;

    final result = await fetchData(
      pagination,
      pageSize,
      totalRecords,
      parentItem,
    );

    pagination += 1;

    _updateData(result, parentItem);

    notifyListeners();
  }

  void _updateData(List<ListItem> result, [ListItem? parentItem]) {
    if (parentItem != null) {
      for (var item in result) {
        _items[parentItem.id]!.subItems.putIfAbsent(item.id, () => item);
        _items[parentItem.id]!.orderList.add(item.id);
      }
    } else {
      for (var item in result) {
        _orderList.insert(_orderList.length - 1, item.id);
        _items.putIfAbsent(item.id, () => item);
      }
    }

    stateType = StateType.data;
  }

  ListItem? item(int index) {
    return _items[_orderList[index]];
  }

  ListItem? subItem(int parentId, int index) {
    final parentItem = _items[parentId];

    return parentItem?.subItems[parentItem.orderList[index]];
  }

  int indexOf(ListItem item) => _orderList.indexOf(item.id);
  int indexOfSub(ListItem parentItem, ListItem subItem) =>
      parentItem.orderList.indexOf(subItem.id);
  int get length => _items.length;

  void add(ListItem item) {
    _orderList.add(item.id);
    _items.putIfAbsent(item.id, () => item);

    notifyListeners();
  }

  void reOrder({
    ListItem? newParentItem,
    required int newIndex,
  }) {
    print('newParentItem: ${newParentItem?.id}, newIndex: $newIndex');

    if (oldIndex == null) return;

    int? tempId;
    ListItem? tempItem;

    if (oldParentItem != null) {
      tempId = _items[oldParentItem?.id]?.orderList[oldIndex!];
      tempItem = _items[oldParentItem?.id]?.subItems[tempId];

      _items[oldParentItem?.id]?.orderList.removeAt(oldIndex!);
      _items[oldParentItem?.id]?.subItems.remove(tempId);
    } else {
      tempId = _orderList[oldIndex!];
      tempItem = _items[tempId];

      _orderList.removeAt(oldIndex!);
      _items.remove(tempId);
    }

    if (tempId == null || tempItem == null) return;

    if (newParentItem != null) {
      _items[newParentItem.id]?.subItems.putIfAbsent(tempId, () => tempItem!);
      _items[newParentItem.id]?.orderList.insert(newIndex, tempId);
    } else {
      _items.putIfAbsent(tempId, () => tempItem!);
      _orderList.insert(newIndex, tempId);
    }

    oldParentItem = null;
    oldIndex = null;

    notifyListeners();
  }

  void insert(int index, ListItem item) {
    _orderList.insert(index, item.id);
    _items.putIfAbsent(item.id, () => item);

    notifyListeners();
  }

  void addAll(List<ListItem> items) {
    for (var item in items) {
      _items.addAll({item.id: item});
      _orderList.add(item.id);
    }

    notifyListeners();
  }

  void removeAll() {
    _items.clear();

    notifyListeners();
  }

  void addChild(int parentIndex, ListItem listItem) {
    final parentId = _orderList[parentIndex];
    _items[parentId]!.subItems.putIfAbsent(listItem.id, () => listItem);
    _items[parentId]!.orderList.add(listItem.id);
  }
}
