import '../entities/item.dart';
import '../repositories/item_repository.dart';

class CreateItem {
  final ItemRepository repository;

  CreateItem(this.repository);

  Future<void> execute(Item item) {
    return repository.addItem(item);
  }
}