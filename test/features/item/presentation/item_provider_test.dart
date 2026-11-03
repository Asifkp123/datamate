import 'package:flutter_test/flutter_test.dart';
import 'package:datamate_assessment/features/category/domain/entities/category.dart';
import 'package:datamate_assessment/features/category/domain/repositories/category_repository.dart';
import 'package:datamate_assessment/features/category/domain/usecases/get_categories.dart';
import 'package:datamate_assessment/features/item/domain/entities/item.dart';
import 'package:datamate_assessment/features/item/domain/repositories/item_repository.dart';
import 'package:datamate_assessment/features/item/domain/usecases/create_items.dart';
import 'package:datamate_assessment/features/item/domain/usecases/get_items.dart';
import 'package:datamate_assessment/features/item/presentation/item_provider.dart';

class StubCategoryRepository implements CategoryRepository {
  @override
  Future<List<Category>> getCategories() async {
    return const [
      Category(id: 'CAT_TEST', name: 'Test Category'),
    ];
  }

  @override
  Future<void> addCategory(Category category) async {}
}

class StubItemRepository implements ItemRepository {
  final List<Item> items = [];

  @override
  Future<List<Item>> getItems() async => List.from(items);

  @override
  Future<void> addItem(Item item) async {
    items.add(item);
  }
}

void main() {
  test('ItemProvider loads categories via injected GetCategories use case independently', () async {
    final categoryRepo = StubCategoryRepository();
    final itemRepo = StubItemRepository();

    final provider = ItemProvider(
      getItems: GetItems(itemRepo),
      createItem: CreateItem(itemRepo),
      getCategories: GetCategories(categoryRepo),
    );

    expect(provider.categories, isEmpty);

    await provider.fetchCategories();

    // Verifies that Item feature successfully retrieves categories through the use case contract
    expect(provider.categories.length, 1);
    expect(provider.categories.first.id, 'CAT_TEST');
    expect(provider.categories.first.name, 'Test Category');
  });

  test('ItemProvider adds an item and updates items list', () async {
    final categoryRepo = StubCategoryRepository();
    final itemRepo = StubItemRepository();

    final provider = ItemProvider(
      getItems: GetItems(itemRepo),
      createItem: CreateItem(itemRepo),
      getCategories: GetCategories(categoryRepo),
    );

    await provider.addItem(name: 'Pizza', categoryId: 'CAT_TEST');

    expect(provider.items.length, 1);
    expect(provider.items.first.name, 'Pizza');
    expect(provider.items.first.categoryId, 'CAT_TEST');
  });
}
