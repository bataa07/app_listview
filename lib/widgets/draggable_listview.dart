import 'package:app_listview/models/list_item.dart';
import 'package:app_listview/notifier/list_item_notifier.dart';
import 'package:app_listview/widgets/draggable_list_item.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

int globalId = 0;

class DraggableListview extends StatefulWidget {
  const DraggableListview({
    super.key,
    required this.pageKey,
    required this.scrollController,
  });

  final PageStorageKey<String> pageKey;
  final ScrollController scrollController;

  @override
  State<DraggableListview> createState() => _DraggableListviewState();
}

class _DraggableListviewState extends State<DraggableListview> {
  ListItemNotifier listItemNotifier = ListItemNotifier(
    fetchData: (pagination, pageSize, totalRecords, [parentItem]) async {
      List<ListItem> listItems = [];

      await Future.delayed(
        const Duration(seconds: 1),
        () {
          for (var i = 0; i < pageSize; i++) {
            listItems.add(ListItem(
              id: globalId,
              title: globalId.toString(),
              subItems: {},
              orderList: [],
            ));

            globalId += 1;
          }
        },
      );

      return listItems;
    },
  )..init();

  @override
  void initState() {
    super.initState();

    listItemNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    listItemNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.custom(
      controller: widget.scrollController,
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = listItemNotifier.item(index);

          GlobalKey itemKey = GlobalKey();
          final valueKey = ValueKey<ListItem>(item!);

          return DraggableListItem(
            key: valueKey,
            index: index,
            item: item,
            itemKey: itemKey,
            notifier: listItemNotifier,
            child: item.id == -1
                ? VisibilityDetector(
                    key: valueKey,
                    onVisibilityChanged: (info) {
                      listItemNotifier.fetchNextData();
                    },
                    child: ListTile(
                      key: itemKey,
                      title: const Text('Listview Indicator'),
                    ),
                  )
                : SizedBox(
                    key: itemKey,
                    child: ExpansionTile(
                      key: PageStorageKey(item),
                      leading: Text(item.id.toString()),
                      title: Text(item.title.toString()),
                      children: [
                        ListView.custom(
                          key: PageStorageKey(item),
                          shrinkWrap: true,
                          childrenDelegate: SliverChildBuilderDelegate(
                            (context, subIndex) {
                              final subItem =
                                  listItemNotifier.subItem(item.id, subIndex);

                              GlobalKey subItemKey = GlobalKey();
                              final subValueKey = ValueKey<ListItem>(subItem!);

                              return DraggableListItem(
                                key: subValueKey,
                                index: subIndex,
                                item: subItem,
                                parentItem: item,
                                itemKey: subItemKey,
                                notifier: listItemNotifier,
                                child: ListTile(
                                  key: subItemKey,
                                  leading: Text(subItem.id.toString()),
                                  title: Text(subItem.title.toString()),
                                  onTap: () {},
                                ),
                              );
                            },
                            childCount: item.subItems.length,
                            findChildIndexCallback: (key) {
                              final subValueKey = key as ValueKey<ListItem>;
                              int index = listItemNotifier.indexOfSub(
                                item,
                                subValueKey.value,
                              );

                              if (index == -1) return null;

                              return index;
                            },
                          ),
                        ),
                        VisibilityDetector(
                          key: ValueKey(item),
                          onVisibilityChanged: (info) {
                            if (info.visibleFraction >= 1) {
                              listItemNotifier.fetchNextData(item);
                            }
                          },
                          child: Container(height: 8.0),
                        ),
                      ],
                    ),
                  ),
          );
        },
        childCount: listItemNotifier.length,
        findChildIndexCallback: (key) {
          final valueKey = key as ValueKey<ListItem>;
          int index = listItemNotifier.indexOf(valueKey.value);

          if (index == -1) return null;

          return index;
        },
      ),
    );
  }
}
