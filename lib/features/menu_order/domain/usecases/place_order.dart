import '../entities/order.dart';
import '../repositories/order_repository.dart';

class PlaceOrder {
  final OrderRepository repository;

  PlaceOrder(this.repository);

  Future<void> execute(Order order) {
    return repository.placeOrder(order);
  }
}