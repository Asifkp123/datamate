import '../../domain/entities/item.dart';

abstract class ItemDataSource {
  Future<List<Item>> getItems();

  Future<void> addItem(Item item);
}