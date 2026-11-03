import '../../domain/entities/category.dart';

abstract class CategoryDataSource {
  Future<List<Category>> getCategories();

  Future<void>addCategory(Category category);

}