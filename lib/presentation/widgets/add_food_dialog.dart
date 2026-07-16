import 'package:flutter/material.dart';

import '../../application/app_state.dart';
import '../../domain/models.dart';

Future<void> showAddFoodDialog(BuildContext context, AppState state) async {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController(text: '1');
  final TextEditingController unitController = TextEditingController(text: 'Stück');
  final TextEditingController locationController = TextEditingController(text: 'Kühlschrank');
  FoodCategory category = FoodCategory.vegetables;
  DateTime expiryDate = DateTime.now().add(const Duration(days: 7));
  final bool? shouldAdd = await showDialog<bool>(context: context, builder: (BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setDialogState) {
      return AlertDialog(
        title: const Text('Lebensmittel hinzufügen'),
        content: SizedBox(width: 500, child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          TextField(controller: nameController, autofocus: true, decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.restaurant_outlined))),
          const SizedBox(height: 14),
          DropdownButtonFormField<FoodCategory>(initialValue: category, decoration: const InputDecoration(labelText: 'Kategorie', prefixIcon: Icon(Icons.category_outlined)), items: FoodCategory.values.map((FoodCategory value) => DropdownMenuItem<FoodCategory>(value: value, child: Text('${value.emoji}  ${value.label}'))).toList(), onChanged: (FoodCategory? value) { if (value != null) setDialogState(() => category = value); }),
          const SizedBox(height: 14),
          Row(children: <Widget>[Expanded(child: TextField(controller: quantityController, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Menge'))), const SizedBox(width: 12), Expanded(child: TextField(controller: unitController, decoration: const InputDecoration(labelText: 'Einheit')))]),
          const SizedBox(height: 14),
          TextField(controller: locationController, decoration: const InputDecoration(labelText: 'Lagerort', prefixIcon: Icon(Icons.kitchen_outlined))),
          const SizedBox(height: 14),
          ListTile(contentPadding: EdgeInsets.zero, leading: const Icon(Icons.event_outlined), title: const Text('Ablaufdatum'), subtitle: Text('${expiryDate.day.toString().padLeft(2, '0')}.${expiryDate.month.toString().padLeft(2, '0')}.${expiryDate.year}'), trailing: const Icon(Icons.chevron_right), onTap: () async { final DateTime? picked = await showDatePicker(context: context, initialDate: expiryDate, firstDate: DateTime.now().subtract(const Duration(days: 1)), lastDate: DateTime.now().add(const Duration(days: 730))); if (picked != null) setDialogState(() => expiryDate = picked); }),
        ]))),
        actions: <Widget>[TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Abbrechen')), FilledButton(onPressed: () { if (nameController.text.trim().isNotEmpty) Navigator.of(context).pop(true); }, child: const Text('Hinzufügen'))],
      );
    });
  });
  if (shouldAdd == true) {
    final double quantity = double.tryParse(quantityController.text.replaceAll(',', '.')) ?? 1;
    state.addFood(FoodItem(id: DateTime.now().microsecondsSinceEpoch.toString(), name: nameController.text.trim(), category: category, quantity: quantity, unit: unitController.text.trim().isEmpty ? 'Stück' : unitController.text.trim(), expiryDate: expiryDate, location: locationController.text.trim().isEmpty ? 'Kühlschrank' : locationController.text.trim()));
  }
  nameController.dispose(); quantityController.dispose(); unitController.dispose(); locationController.dispose();
}
