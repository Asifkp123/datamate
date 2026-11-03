import 'package:datamate_assessment/features/category/domain/usecases/add_category.dart';
import 'package:flutter/material.dart';

import '../domain/entities/category.dart';
import '../domain/usecases/get_categories.dart';


class CategoryProvider extends ChangeNotifier {
  final GetCategories getCategories;
  final AddCategories addCategories;

  CategoryProvider(this.getCategories,this.addCategories);

  List<Category> categories = [];

  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchCategories() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      categories = await getCategories.execute();
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
  Future<void> addNewCategory(String name) async {
    try {
      final category = Category(
        id: (categories.length + 1).toString(),
        name: name,
      );

      await addCategories.execute(category);
      await fetchCategories();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}