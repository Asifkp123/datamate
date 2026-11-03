import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';
import '../datasources/item_data_source.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemDataSource dataSource;

  ItemRepositoryImpl(this.dataSource);

  @override
  Future<List<Item>> getItems() {
    return dataSource.getItems();
  }

  @override
  Future<void> addItem(Item item) {
    return dataSource.addItem(item);
  }
}