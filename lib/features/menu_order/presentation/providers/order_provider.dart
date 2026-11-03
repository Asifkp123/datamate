import 'package:flutter/material.dart';

import '../../domain/entities/order.dart';
import '../../domain/usecases/place_order.dart';
import '../../domain/usecases/get_orders.dart';

// Reuse Item feature
import '../../../item/domain/entities/item.dart';
import '../../../item/domain/usecases/get_items.dart';

class OrderProvider extends ChangeNotifier {
  final GetItems getItems;
  final PlaceOrder placeOrder;
  final GetOrders getOrders;

  OrderProvider({
    required this.getItems,
    required this.placeOrder,
    required this.getOrders,
  });

  List<Item> items = [];
  List<Order> orders = [];

  final List<String> selectedItemIds = [];

  bool isLoading = false;
  bool isPlacingOrder = false;
  String? errorMessage;

  // Load available menu items
  Future<void> fetchItems() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      items = await getItems.execute();
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  // Select or unselect an item
  void toggleItem(String itemId) {
    if (selectedItemIds.contains(itemId)) {
      selectedItemIds.remove(itemId);
    } else {
      selectedItemIds.add(itemId);
    }

    notifyListeners();
  }

  // Place mock order
  Future<void> submitOrder() async {
    if (selectedItemIds.isEmpty) {
      errorMessage = 'Please select at least one item';
      notifyListeners();
      return;
    }

    isPlacingOrder = true;
    errorMessage = null;
    notifyListeners();

    try {
      final order = Order(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        itemIds: List<String>.from(selectedItemIds),
        createdAt: DateTime.now(),
      );

      await placeOrder.execute(order);

      selectedItemIds.clear();

      orders = await getOrders.execute();
    } catch (e) {
      errorMessage = e.toString();
    }

    isPlacingOrder = false;
    notifyListeners();
  }



  Future<void> fetchOrders() async {
    try {
      orders = await getOrders.execute();
      errorMessage = null;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}