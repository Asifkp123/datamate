import 'package:flutter_test/flutter_test.dart';
import 'package:datamate_assessment/features/menu_order/domain/entities/order.dart';
import 'package:datamate_assessment/features/menu_order/domain/repositories/order_repository.dart';
import 'package:datamate_assessment/features/menu_order/domain/usecases/place_order.dart';

class FakeOrderRepository implements OrderRepository {
  Order? savedOrder;

  @override
  Future<void> placeOrder(Order order) async {
    savedOrder = order;
  }

  @override
  Future<List<Order>> getOrders() async {
    return savedOrder == null ? [] : [savedOrder!];
  }
}

void main() {
  test('should save an order through repository', () async {
    final repository = FakeOrderRepository();
    final useCase = PlaceOrder(repository);

    final order = Order(
      id: 'ORD001',
      itemIds: ['101', '103'],
      createdAt: DateTime(2026, 11, 3),
    );

    await useCase.execute(order);

    expect(repository.savedOrder, isNotNull);
    expect(repository.savedOrder!.id, 'ORD001');
    expect(repository.savedOrder!.itemIds, ['101', '103']);
  });
}