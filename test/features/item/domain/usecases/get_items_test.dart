import 'package:flutter_test/flutter_test.dart';
import 'package:datamate_assessment/features/item/domain/entities/item.dart';
import 'package:datamate_assessment/features/item/domain/repositories/item_repository.dart';
import 'package:datamate_assessment/features/item/domain/usecases/get_items.dart';
import 'package:datamate_assessment/features/item/domain/usecases/create_items.dart';

class FakeItemRepository implements ItemRepository {
  final List<Item> _items = [
    const Item(id: '101', name: 'Laptop', categoryId: '1'),
    const Item(id: '102', name: 'Burger', categoryId: '2'),
  ];

  @override
  Future<List<Item>> getItems() async {
    return List.from(_items);
  }

  @override
  Future<void> addItem(Item item) async {
    _items.add(item);
  }
}

void main() {
  late FakeItemRepository repository;
  late GetItems getItems;
  late CreateItem createItem;

  setUp(() {
    repository = FakeItemRepository();
    getItems = GetItems(repository);
    createItem = CreateItem(repository);
  });

  test('should return all items from repository', () async {
    final result = await getItems.execute();

    expect(result.length, 2);
    expect(result.first.name, 'Laptop');
  });

  test('should add new item and be retrievable', () async {
    const newItem = Item(id: '103', name: 'Coffee', categoryId: '2');
    await createItem.execute(newItem);

    final result = await getItems.execute();
    expect(result.length, 3);
    expect(result.any((item) => item.id == '103' && item.name == 'Coffee'), isTrue);
  });
}
