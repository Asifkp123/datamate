import '../entities/order.dart';

abstract class OrderRepository {
  Future<void> placeOrder(Order order);

  Future<List<Order>> getOrders();
}