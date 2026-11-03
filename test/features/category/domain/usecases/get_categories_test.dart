import 'package:flutter_test/flutter_test.dart';
import 'package:datamate_assessment/features/category/domain/entities/category.dart';
import 'package:datamate_assessment/features/category/domain/repositories/category_repository.dart';
import 'package:datamate_assessment/features/category/domain/usecases/get_categories.dart';
import 'package:datamate_assessment/features/category/domain/usecases/add_category.dart';

class FakeCategoryRepository implements CategoryRepository {
  final List<Category> _categories = [
    const Category(id: '1', name: 'Electronics'),
    const Category(id: '2', name: 'Food'),
  ];

  @override
  Future<List<Category>> getCategories() async {
    return List.from(_categories);
  }

  @override
  Future<void> addCategory(Category category) async {
    _categories.add(category);
  }
}

void main() {
  late FakeCategoryRepository repository;
  late GetCategories getCategories;
  late AddCategories addCategories;

  setUp(() {
    repository = FakeCategoryRepository();
    getCategories = GetCategories(repository);
    addCategories = AddCategories(repository);
  });

  test('should return all categories from repository', () async {
    final result = await getCategories.execute();

    expect(result.length, 2);
    expect(result.first.name, 'Electronics');
  });

  test('should add new category and be retrievable', () async {
    const newCategory = Category(id: '3', name: 'Books');
    await addCategories.execute(newCategory);

    final result = await getCategories.execute();
    expect(result.length, 3);
    expect(result.any((c) => c.name == 'Books'), isTrue);
  });
}
