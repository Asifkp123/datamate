import '../../domain/entities/order.dart';

abstract class OrderDataSource {
  Future<void> placeOrder(Order order);

  Future<List<Order>> getOrders();
}