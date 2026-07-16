import 'package:flutter_test/flutter_test.dart';
import 'package:whats_in_my_fridge/domain/models.dart';

void main() {
  test('FoodItem calculates expiry status', () {
    final DateTime today = DateTime.now();
    final FoodItem item = FoodItem(id: 'test', name: 'Testprodukt', category: FoodCategory.pantry, quantity: 1, unit: 'Stück', expiryDate: today.add(const Duration(days: 3)), location: 'Vorrat');
    expect(item.daysUntilExpiry, 3);
    expect(item.expiresThisWeek, isTrue);
  });
}
