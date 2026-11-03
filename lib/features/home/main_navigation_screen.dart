import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../category/presentation/category_provider.dart';
import '../category/presentation/category_screen.dart';
import '../item/presentation/item_provider.dart';
import '../item/presentation/item_screen.dart';
import '../menu_order/presentation/providers/order_provider.dart';
import '../menu_order/presentation/screens/menu_order_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    MenuOrderScreen(),
    ItemScreen(),
    CategoryScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Refresh data dynamically when navigating between features
    if (index == 0) {
      context.read<OrderProvider>().fetchItems();
    } else if (index == 1) {
      final itemProvider = context.read<ItemProvider>();
      itemProvider.fetchCategories();
      itemProvider.fetchItems();
    } else if (index == 2) {
      context.read<CategoryProvider>().fetchCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onTabSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Menu Order',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Item Master',
          ),
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: 'Category Master',
          ),
        ],
      ),
    );
  }
}
