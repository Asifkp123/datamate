import '../../domain/entities/category.dart';
import 'category_data_source.dart';

class CategoryLocalDataSourceImpl implements CategoryDataSource {

  final List<Category> categories = [
    const Category(id: '1', name: 'Electronics'),
    const Category(id: '2', name: 'Furniture'),
    const Category(id: '3', name: 'Food'),
  ];

  @override
  Future<List<Category>> getCategories() async {
    return categories;
  }

  @override
  Future<void> addCategory(Category category) async {
    categories.add(category);
  }
}