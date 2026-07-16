import 'package:flutter/material.dart';

import '../domain/models.dart';

class AppState extends ChangeNotifier {
  AppState._({
    required List<FoodItem> inventory,
    required List<Recipe> recipes,
    required List<ShoppingItem> shoppingItems,
  })  : _inventory = inventory,
        _recipes = recipes,
        _shoppingItems = shoppingItems;

  factory AppState.seeded() {
    final DateTime now = DateTime.now();
    return AppState._(
      inventory: <FoodItem>[
        FoodItem(id: 'milk', name: 'Bio-Milch', category: FoodCategory.dairy, quantity: 1, unit: 'Liter', expiryDate: now, location: 'Kühlschrank'),
        FoodItem(id: 'spinach', name: 'Babyspinat', category: FoodCategory.vegetables, quantity: 250, unit: 'g', expiryDate: now.add(const Duration(days: 2)), location: 'Gemüsefach'),
        FoodItem(id: 'chicken', name: 'Hähnchenbrust', category: FoodCategory.meat, quantity: 450, unit: 'g', expiryDate: now.add(const Duration(days: 3)), location: 'Kühlschrank'),
        FoodItem(id: 'tomatoes', name: 'Cherrytomaten', category: FoodCategory.vegetables, quantity: 500, unit: 'g', expiryDate: now.add(const Duration(days: 5)), location: 'Küche'),
        FoodItem(id: 'oats', name: 'Haferflocken', category: FoodCategory.pantry, quantity: 1, unit: 'Packung', expiryDate: now.add(const Duration(days: 110)), location: 'Vorratsschrank'),
        FoodItem(id: 'berries', name: 'Beerenmix', category: FoodCategory.frozen, quantity: 600, unit: 'g', expiryDate: now.add(const Duration(days: 90)), location: 'Gefrierschrank'),
      ],
      recipes: const <Recipe>[
        Recipe(id: 'bowl', title: 'Protein-Gemüse-Bowl', subtitle: 'Schnell, sättigend und perfekt für vorhandene Reste.', emoji: '🥗', minutes: 25, matchPercent: 92, ingredients: <String>['Hähnchenbrust', 'Babyspinat', 'Cherrytomaten', 'Reis'], isFavorite: true),
        Recipe(id: 'smoothie', title: 'Beeren-Frühstück', subtitle: 'Cremiges Frühstück aus Beeren, Haferflocken und Milch.', emoji: '🫐', minutes: 8, matchPercent: 88, ingredients: <String>['Beerenmix', 'Haferflocken', 'Bio-Milch']),
        Recipe(id: 'pasta', title: 'Tomaten-Spinat-Pasta', subtitle: 'Einfaches Abendessen mit wenigen Zutaten.', emoji: '🍝', minutes: 20, matchPercent: 78, ingredients: <String>['Cherrytomaten', 'Babyspinat', 'Nudeln']),
        Recipe(id: 'wrap', title: 'Chicken-Wraps', subtitle: 'Knackig, proteinreich und gut zum Mitnehmen.', emoji: '🌯', minutes: 18, matchPercent: 71, ingredients: <String>['Hähnchenbrust', 'Tomaten', 'Wraps']),
      ],
      shoppingItems: const <ShoppingItem>[
        ShoppingItem(id: 'rice', name: 'Reis'),
        ShoppingItem(id: 'wraps', name: 'Vollkorn-Wraps'),
        ShoppingItem(id: 'yoghurt', name: 'Naturjoghurt', done: true),
      ],
    );
  }

  final List<FoodItem> _inventory;
  final List<Recipe> _recipes;
  final List<ShoppingItem> _shoppingItems;
  ThemeMode _themeMode = ThemeMode.system;
  int _selectedPage = 0;

  List<FoodItem> get inventory => List<FoodItem>.unmodifiable(_inventory);
  List<Recipe> get recipes => List<Recipe>.unmodifiable(_recipes);
  List<ShoppingItem> get shoppingItems => List<ShoppingItem>.unmodifiable(_shoppingItems);
  ThemeMode get themeMode => _themeMode;
  int get selectedPage => _selectedPage;
  int get expiringToday => _inventory.where((FoodItem item) => item.daysUntilExpiry == 0).length;
  int get expiringThisWeek => _inventory.where((FoodItem item) => item.expiresThisWeek).length;
  int get favoriteRecipes => _recipes.where((Recipe recipe) => recipe.isFavorite).length;
  int get completedShopping => _shoppingItems.where((ShoppingItem item) => item.done).length;

  List<FoodItem> get urgentItems {
    final List<FoodItem> items = _inventory.where((FoodItem item) => item.daysUntilExpiry <= 7).toList();
    items.sort((FoodItem a, FoodItem b) => a.expiryDate.compareTo(b.expiryDate));
    return items;
  }

  void selectPage(int index) { if (_selectedPage == index) return; _selectedPage = index; notifyListeners(); }
  void setThemeMode(ThemeMode mode) { if (_themeMode == mode) return; _themeMode = mode; notifyListeners(); }
  void addFood(FoodItem item) { _inventory.insert(0, item); notifyListeners(); }
  void removeFood(String id) { _inventory.removeWhere((FoodItem item) => item.id == id); notifyListeners(); }
  void toggleRecipeFavorite(String id) { final int index = _recipes.indexWhere((Recipe recipe) => recipe.id == id); if (index == -1) return; _recipes[index] = _recipes[index].copyWith(isFavorite: !_recipes[index].isFavorite); notifyListeners(); }
  void addShoppingItem(String name) { final String trimmed = name.trim(); if (trimmed.isEmpty) return; _shoppingItems.add(ShoppingItem(id: DateTime.now().microsecondsSinceEpoch.toString(), name: trimmed)); notifyListeners(); }
  void toggleShoppingItem(String id) { final int index = _shoppingItems.indexWhere((ShoppingItem item) => item.id == id); if (index == -1) return; _shoppingItems[index] = _shoppingItems[index].copyWith(done: !_shoppingItems[index].done); notifyListeners(); }
  void removeShoppingItem(String id) { _shoppingItems.removeWhere((ShoppingItem item) => item.id == id); notifyListeners(); }
}
