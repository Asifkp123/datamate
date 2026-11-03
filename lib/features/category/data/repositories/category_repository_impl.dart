import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource dataSource;

  CategoryRepositoryImpl(this.dataSource);

  @override
  Future<List<Category>> getCategories() {
    return dataSource.getCategories();
  }

  @override
  Future<void>addCategory(Category category)async {
    await dataSource.addCategory(category);
  }



}