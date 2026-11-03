import 'package:datamate_assessment/features/category/domain/usecases/add_category.dart';
import 'package:datamate_assessment/features/menu_order/data/datasources/order_data_source.dart';

import 'features/category/data/datasources/category_data_source.dart';
import 'features/category/data/datasources/category_local_data_source_impl.dart';
import 'features/category/data/repositories/category_repository_impl.dart';
import 'features/category/domain/repositories/category_repository.dart';
import 'features/category/domain/usecases/get_categories.dart';
import 'features/item/data/datasources/item_data_source.dart';
import 'features/item/data/datasources/item_local_data_source_impl.dart';
import 'features/item/data/repositories/item_repository_impl.dart';
import 'features/item/domain/repositories/item_repository.dart';
import 'features/item/domain/usecases/create_items.dart';
import 'features/item/domain/usecases/get_items.dart';
import 'features/menu_order/data/datasources/order_local_data_source_impl.dart';
import 'features/menu_order/data/repositories/order_repository_impl.dart';
import 'features/menu_order/domain/repositories/order_repository.dart';
import 'features/menu_order/domain/usecases/get_orders.dart';
import 'features/menu_order/domain/usecases/place_order.dart';

// Data Source
final CategoryDataSource categoryDataSource = CategoryLocalDataSourceImpl();

// Repository
final CategoryRepository categoryRepository =
CategoryRepositoryImpl(categoryDataSource);

// Use Case
final GetCategories getCategories =
GetCategories(categoryRepository);
// Use Case
final AddCategories addCategories =
AddCategories(categoryRepository);

// Item Feature
final ItemDataSource itemDataSource = ItemLocalDataSourceImpl();
final ItemRepository itemRepository = ItemRepositoryImpl(itemDataSource);
final GetItems getItems = GetItems(itemRepository);
final CreateItem createItem = CreateItem(itemRepository);




// place order
final OrderDataSource orderDataSource = OrderLocalDataSourceImpl();
final OrderRepository orderRepository = OrderRepositoryImpl(orderDataSource);
final PlaceOrder placeOrder = PlaceOrder(orderRepository);
final GetOrders getOrders = GetOrders(orderRepository);



