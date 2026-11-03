class Order {
  final String id;
  final List<String> itemIds;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.itemIds,
    required this.createdAt,
  });
}