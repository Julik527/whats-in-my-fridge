import 'package:flutter/material.dart';

import '../../application/app_state.dart';
import '../../core/utils/date_helpers.dart';
import '../../domain/models.dart';
import '../widgets/add_food_dialog.dart';
import '../widgets/common_widgets.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({required this.state, super.key});
  final AppState state;
  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String _query = '';
  FoodCategory? _category;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<FoodItem> filtered = widget.state.inventory.where((FoodItem item) => item.name.toLowerCase().contains(_query.toLowerCase()) && (_category == null || item.category == _category)).toList();
    return Column(children: <Widget>[
      PageHeader(title: 'Mein Vorrat', subtitle: 'Durchsuche, filtere und pflege deine Lebensmittel.', action: FilledButton.icon(onPressed: () => showAddFoodDialog(context, widget.state), icon: const Icon(Icons.add), label: const Text('Hinzufügen'))),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: TextField(onChanged: (String value) => setState(() => _query = value), decoration: const InputDecoration(hintText: 'Lebensmittel suchen …', prefixIcon: Icon(Icons.search)))),
      const SizedBox(height: 14),
      SizedBox(height: 42, child: ListView(padding: const EdgeInsets.symmetric(horizontal: 24), scrollDirection: Axis.horizontal, children: <Widget>[
        FilterChip(label: const Text('Alle'), selected: _category == null, onSelected: (_) => setState(() => _category = null)),
        const SizedBox(width: 8),
        ...FoodCategory.values.map((FoodCategory category) => Padding(padding: const EdgeInsets.only(right: 8), child: FilterChip(label: Text('${category.emoji} ${category.label}'), selected: _category == category, onSelected: (_) => setState(() => _category = category)))),
      ])),
      const SizedBox(height: 16),
      Expanded(child: filtered.isEmpty ? const EmptyMessage(icon: Icons.search_off, title: 'Nichts gefunden', message: 'Passe Suche oder Filter an.') : LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        final int columns = constraints.maxWidth >= 1200 ? 4 : constraints.maxWidth >= 820 ? 3 : constraints.maxWidth >= 560 ? 2 : 1;
        return GridView.builder(padding: const EdgeInsets.fromLTRB(24, 0, 24, 32), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: columns == 1 ? 2.8 : 1.35), itemCount: filtered.length, itemBuilder: (BuildContext context, int index) {
          final FoodItem item = filtered[index];
          return SurfaceCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Row(children: <Widget>[Container(width: 48, height: 48, alignment: Alignment.center, decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(16)), child: Text(item.category.emoji, style: const TextStyle(fontSize: 25))), const Spacer(), IconButton(tooltip: 'Löschen', onPressed: () => widget.state.removeFood(item.id), icon: const Icon(Icons.delete_outline))]),
            const Spacer(),
            Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text('${item.quantity.readable} ${item.unit} • ${item.location}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Row(children: <Widget>[Icon(Icons.event_outlined, size: 18, color: item.daysUntilExpiry <= 1 ? scheme.error : scheme.primary), const SizedBox(width: 6), Expanded(child: Text('${shortDate(item.expiryDate)} • ${expiryLabel(item.expiryDate)}', style: TextStyle(color: item.daysUntilExpiry <= 1 ? scheme.error : scheme.onSurfaceVariant, fontWeight: FontWeight.w600)))]),
          ]));
        });
      })),
    ]);
  }
}

extension _ReadableDouble on double { String get readable => this == roundToDouble() ? toInt().toString() : toString(); }
