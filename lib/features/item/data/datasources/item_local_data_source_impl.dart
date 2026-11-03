import '../../domain/entities/item.dart';
import 'item_data_source.dart';

class ItemLocalDataSourceImpl implements ItemDataSource {
  final List<Item> items = [
    const Item(
      id: '101',
      name: 'Chicken Burger',
      categoryId: '3',
    ),
    const Item(
      id: '102',
      name: 'Laptop',
      categoryId: '1',
    ),
    const Item(
      id: '103',
      name: 'Coffee',
      categoryId: '3',
    ),
  ];

  @override
  Future<List<Item>> getItems() async {
    return items;
  }

  @override
  Future<void> addItem(Item item) async {
    items.add(item);
  }
}