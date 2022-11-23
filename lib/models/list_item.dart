class ListItem {
  ListItem({
    required this.id,
    required this.title,
    required this.subItems,
    required this.orderList,
  });

  ListItem.indicator({
    this.id = -1,
    this.title = '',
    this.subItems = const {},
    this.orderList = const [],
  });

  final int id;
  final String title;
  final Map<int, ListItem> subItems;
  final List<int> orderList;
}
