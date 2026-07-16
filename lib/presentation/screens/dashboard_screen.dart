import 'package:flutter/material.dart';

import '../../application/app_state.dart';
import '../../core/utils/date_helpers.dart';
import '../../domain/models.dart';
import '../widgets/add_food_dialog.dart';
import '../widgets/common_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({required this.state, super.key});
  final AppState state;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      PageHeader(title: 'Guten Morgen, Julian 👋', subtitle: 'Behalte deinen Vorrat im Blick und verschwende weniger.', action: FilledButton.icon(onPressed: () => showAddFoodDialog(context, state), icon: const Icon(Icons.add), label: const Text('Lebensmittel'))),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Container(width: double.infinity, padding: const EdgeInsets.all(24), decoration: BoxDecoration(gradient: LinearGradient(colors: <Color>[scheme.primary, Color.lerp(scheme.primary, scheme.tertiary, 0.55)!], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(28)), child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        final Widget text = Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Text('Heute zuerst verbrauchen', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white.withValues(alpha: 0.82))), const SizedBox(height: 8), Text(state.urgentItems.isEmpty ? 'Alles entspannt.' : '${state.urgentItems.length} Lebensmittel brauchen Aufmerksamkeit.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)), const SizedBox(height: 8), Text('Plane sie direkt in ein Rezept ein und halte deinen Einkauf schlank.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white.withValues(alpha: 0.84))) ]);
        final Widget button = FilledButton.tonalIcon(onPressed: () => state.selectPage(2), icon: const Icon(Icons.auto_awesome_outlined), label: const Text('Rezepte ansehen'));
        return constraints.maxWidth < 650 ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[text, const SizedBox(height: 20), button]) : Row(children: <Widget>[Expanded(child: text), const SizedBox(width: 24), button]);
      }))),
      const SizedBox(height: 22),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Wrap(spacing: 14, runSpacing: 14, children: <Widget>[
        MetricCard(label: 'Lebensmittel im Vorrat', value: '${state.inventory.length}', icon: Icons.inventory_2_outlined, accent: scheme.primary),
        MetricCard(label: 'Laufen heute ab', value: '${state.expiringToday}', icon: Icons.notification_important_outlined, accent: scheme.error),
        MetricCard(label: 'Diese Woche verbrauchen', value: '${state.expiringThisWeek}', icon: Icons.event_available_outlined, accent: scheme.tertiary),
        MetricCard(label: 'Lieblingsrezepte', value: '${state.favoriteRecipes}', icon: Icons.favorite_outline, accent: Colors.pink),
      ])),
      const SizedBox(height: 28),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Row(children: <Widget>[Expanded(child: Text('Bald ablaufend', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800))), TextButton(onPressed: () => state.selectPage(1), child: const Text('Alle ansehen'))])),
      const SizedBox(height: 10),
      Padding(padding: const EdgeInsets.fromLTRB(24, 0, 24, 32), child: state.urgentItems.isEmpty ? const SurfaceCard(child: EmptyMessage(icon: Icons.check_circle_outline, title: 'Alles im grünen Bereich', message: 'Aktuell läuft kein Lebensmittel bald ab.')) : Column(children: state.urgentItems.take(5).map((FoodItem item) => Padding(padding: const EdgeInsets.only(bottom: 10), child: SurfaceCard(padding: const EdgeInsets.all(14), child: Row(children: <Widget>[
        Container(width: 48, height: 48, alignment: Alignment.center, decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(15)), child: Text(item.category.emoji, style: const TextStyle(fontSize: 24))),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Text(item.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)), const SizedBox(height: 3), Text('${item.quantity.g} ${item.unit} • ${item.location}', style: TextStyle(color: scheme.onSurfaceVariant))])),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[Text(expiryLabel(item.expiryDate), style: TextStyle(color: item.daysUntilExpiry <= 1 ? scheme.error : scheme.tertiary, fontWeight: FontWeight.w700)), const SizedBox(height: 3), Text(shortDate(item.expiryDate), style: Theme.of(context).textTheme.bodySmall)]),
      ])))).toList())),
    ]));
  }
}

extension _ReadableNumber on double { String get g => this == roundToDouble() ? toInt().toString() : toString(); }
