import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_data_source.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource dataSource;

  OrderRepositoryImpl(this.dataSource);

  @override
  Future<void> placeOrder(Order order) {
    return dataSource.placeOrder(order);
  }

  @override
  Future<List<Order>> getOrders() {
    return dataSource.getOrders();
  }
}