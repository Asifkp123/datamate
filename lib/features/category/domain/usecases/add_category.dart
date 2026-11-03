import 'package:datamate_assessment/features/category/domain/entities/category.dart';
import 'package:datamate_assessment/features/category/domain/repositories/category_repository.dart';

class AddCategories {
  final CategoryRepository repository;

  AddCategories(this.repository);

  Future<void> execute(Category category) async {
    return await repository.addCategory(category);
  }
}