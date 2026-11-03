import 'package:flutter/material.dart';

import '../../category/domain/entities/category.dart';
import '../../category/domain/usecases/get_categories.dart';
import '../domain/entities/item.dart';
import '../domain/usecases/create_items.dart';
import '../domain/usecases/get_items.dart';



class ItemProvider extends ChangeNotifier {
  final GetItems getItems;
  final CreateItem createItem;
  final GetCategories getCategories;

  ItemProvider({
    required this.getItems,
    required this.createItem,
    required this.getCategories,
  });

  List<Item> items = [];
  List<Category> categories = [];

  bool isLoading = false;
  String? errorMessage;

  // Fetch items
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

  // Fetch categories for the item form
  Future<void> fetchCategories() async {
    try {
      categories = await getCategories.execute();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Create item
  Future<void> addItem({
    required String name,
    required String categoryId,
  }) async {
    try {
      final item = Item(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        categoryId: categoryId,
      );

      await createItem.execute(item);

      await fetchItems();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}