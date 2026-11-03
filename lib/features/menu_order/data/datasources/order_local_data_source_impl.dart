import '../../domain/entities/order.dart';
import 'order_data_source.dart';

class OrderLocalDataSourceImpl implements OrderDataSource {
  final List<Order> orders = [];

  @override
  Future<void> placeOrder(Order order) async {
    orders.add(order);
  }

  @override
  Future<List<Order>> getOrders() async {
    return orders;
  }
}