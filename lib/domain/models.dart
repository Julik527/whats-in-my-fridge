enum FoodCategory {
  dairy,
  meat,
  vegetables,
  fruits,
  drinks,
  frozen,
  pantry,
  snacks,
  condiments,
}

extension FoodCategoryLabel on FoodCategory {
  String get label => switch (this) {
        FoodCategory.dairy => 'Milchprodukte',
        FoodCategory.meat => 'Fleisch',
        FoodCategory.vegetables => 'Gemüse',
        FoodCategory.fruits => 'Obst',
        FoodCategory.drinks => 'Getränke',
        FoodCategory.frozen => 'Tiefkühl',
        FoodCategory.pantry => 'Vorrat',
        FoodCategory.snacks => 'Snacks',
        FoodCategory.condiments => 'Saucen',
      };

  String get emoji => switch (this) {
        FoodCategory.dairy => '🥛',
        FoodCategory.meat => '🍗',
        FoodCategory.vegetables => '🥦',
        FoodCategory.fruits => '🍎',
        FoodCategory.drinks => '🧃',
        FoodCategory.frozen => '❄️',
        FoodCategory.pantry => '🥫',
        FoodCategory.snacks => '🍫',
        FoodCategory.condiments => '🫙',
      };
}

class FoodItem {
  const FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    required this.expiryDate,
    required this.location,
  });

  final String id;
  final String name;
  final FoodCategory category;
  final double quantity;
  final String unit;
  final DateTime expiryDate;
  final String location;

  int get daysUntilExpiry {
    final DateTime today = DateTime.now();
    final DateTime start = DateTime(today.year, today.month, today.day);
    final DateTime target = DateTime(
      expiryDate.year,
      expiryDate.month,
      expiryDate.day,
    );
    return target.difference(start).inDays;
  }

  bool get expiresThisWeek => daysUntilExpiry >= 0 && daysUntilExpiry <= 7;
}

class Recipe {
  const Recipe({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.minutes,
    required this.matchPercent,
    required this.ingredients,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final int minutes;
  final int matchPercent;
  final List<String> ingredients;
  final bool isFavorite;

  Recipe copyWith({bool? isFavorite}) {
    return Recipe(
      id: id,
      title: title,
      subtitle: subtitle,
      emoji: emoji,
      minutes: minutes,
      matchPercent: matchPercent,
      ingredients: ingredients,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class ShoppingItem {
  const ShoppingItem({
    required this.id,
    required this.name,
    this.done = false,
  });

  final String id;
  final String name;
  final bool done;

  ShoppingItem copyWith({bool? done}) {
    return ShoppingItem(id: id, name: name, done: done ?? this.done);
  }
}
