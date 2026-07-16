import 'package:flutter/material.dart';

import '../../application/app_state.dart';
import '../../domain/models.dart';
import '../widgets/common_widgets.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({required this.state, super.key});
  final AppState state;
  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final List<ShoppingItem> items = widget.state.shoppingItems;
    return Column(children: <Widget>[
      PageHeader(title: 'Einkaufsliste', subtitle: '${widget.state.completedShopping} von ${items.length} Artikeln erledigt.'),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Row(children: <Widget>[Expanded(child: TextField(controller: _controller, onSubmitted: (_) => _add(), decoration: const InputDecoration(hintText: 'Neuen Artikel eintragen …', prefixIcon: Icon(Icons.add_shopping_cart)))), const SizedBox(width: 12), FilledButton(onPressed: _add, child: const Text('Hinzufügen'))])),
      const SizedBox(height: 18),
      Expanded(child: items.isEmpty ? const EmptyMessage(icon: Icons.shopping_cart_checkout, title: 'Liste ist leer', message: 'Füge Artikel hinzu, die beim nächsten Einkauf fehlen.') : ListView.separated(padding: const EdgeInsets.fromLTRB(24, 0, 24, 32), itemCount: items.length, separatorBuilder: (_, __) => const SizedBox(height: 10), itemBuilder: (BuildContext context, int index) {
        final ShoppingItem item = items[index];
        return SurfaceCard(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), child: CheckboxListTile(value: item.done, onChanged: (_) => widget.state.toggleShoppingItem(item.id), title: Text(item.name, style: TextStyle(decoration: item.done ? TextDecoration.lineThrough : null, color: item.done ? Theme.of(context).colorScheme.onSurfaceVariant : null)), secondary: IconButton(tooltip: 'Entfernen', onPressed: () => widget.state.removeShoppingItem(item.id), icon: const Icon(Icons.close)), controlAffinity: ListTileControlAffinity.leading));
      })),
    ]);
  }
  void _add() { widget.state.addShoppingItem(_controller.text); _controller.clear(); }
}
