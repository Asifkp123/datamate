

## Architectural Approach

I organized the codebase using a **feature-first** structure instead of a traditional layer-first approach. Each business capability has its own folder containing `domain`, `data`, and `presentation` layers:

```text
lib/
├── features/
│   ├── category/       # Category master (view list & add category)
│   ├── item/           # Item master (view items with assigned category & add item)
│   ├── menu_order/     # Transaction screen (browse items, place order & history)
│   └── home/           # Bottom navigation bar connecting the 3 screens
├── injection_container.dart  # Simple manual DI (composition root)
└── main.dart           # App root & MultiProvider
```

### Layer separation inside each feature:
- **Domain**: Pure Dart with zero Flutter dependencies. Holds entities, repository contracts (interfaces), and use cases (`GetCategories`, `CreateItem`, `PlaceOrder`, etc.).
- **Data**: Implements the repository contracts and interacts with in-memory data sources.
- **Presentation**: UI screens, dialogs, and state management using `ChangeNotifier` / `Provider`.

---

## Cross-Feature Dependency (Item & Category)

One of the key requirements was handling the dependency between the Item and Category features without tight coupling:
- The **Item** feature requires categories (to show category names and populate the category dropdown when adding items).
- Instead of letting `ItemProvider` access `CategoryProvider` or `CategoryScreen` directly, I injected the `GetCategories` usecase into `ItemProvider` via its constructor.

```dart
class ItemProvider extends ChangeNotifier {
  final GetItems getItems;
  final CreateItem createItem;
  final GetCategories getCategories; // Injected use case contract

  ItemProvider({
    required this.getItems,
    required this.createItem,
    required this.getCategories,
  });
  ...
}
```

This ensures:
1. `Item` doesn't care how `Category` manages its UI or state.
2. If `Category`'s presentation logic is refactored, `Item` won't break.
3. `ItemProvider` can be tested independently by passing a fake/stub `GetCategories` usecase.

---

## State Management & Dependency Injection

- **State Management**: I used `Provider` with `ChangeNotifier`. For an in-memory assessment, it provides a clean, reactive separation of concerns without introducing heavy boilerplate.
- **Dependency Injection**: Kept simple and explicit in `lib/injection_container.dart` without extra third-party DI packages, creating data sources → repositories → use cases from the bottom up.

---

## Testing

I added unit tests to verify business logic and cross-feature decoupling:

- `test/features/category/domain/usecases/get_categories_test.dart`: Tests category use cases with a fake repository.
- `test/features/item/domain/usecases/get_items_test.dart`: Tests item retrieval and creation use cases.
- `test/features/item/presentation/item_provider_test.dart`: Proves cross-feature isolation by testing `ItemProvider` with a stub category use case.
- `test/features/menu_order/domain/usecases/place_order_test.dart`: Tests order placement logic.
