import 'package:flutter/material.dart';

import '../application/app_state.dart';
import 'screens/dashboard_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/planner_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/shopping_screen.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.state, super.key});
  final AppState state;
  static const List<NavigationDestination> _destinations = <NavigationDestination>[
    NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard_rounded), label: 'Übersicht'),
    NavigationDestination(icon: Icon(Icons.kitchen_outlined), selectedIcon: Icon(Icons.kitchen_rounded), label: 'Vorrat'),
    NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book_rounded), label: 'Rezepte'),
    NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month_rounded), label: 'Planer'),
    NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), selectedIcon: Icon(Icons.shopping_cart_rounded), label: 'Einkauf'),
    NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings_rounded), label: 'Mehr'),
  ];
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[DashboardScreen(state: state), InventoryScreen(state: state), RecipesScreen(state: state), PlannerScreen(state: state), ShoppingScreen(state: state), SettingsScreen(state: state)];
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final bool useRail = constraints.maxWidth >= 900;
      final Widget content = IndexedStack(index: state.selectedPage, children: pages);
      if (!useRail) return Scaffold(body: SafeArea(child: content), bottomNavigationBar: NavigationBar(selectedIndex: state.selectedPage, onDestinationSelected: state.selectPage, destinations: _destinations));
      return Scaffold(body: SafeArea(child: Row(children: <Widget>[
        Container(width: constraints.maxWidth >= 1180 ? 250 : 96, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, border: Border(right: BorderSide(color: Theme.of(context).colorScheme.outlineVariant))), child: Column(children: <Widget>[
          Padding(padding: const EdgeInsets.fromLTRB(18, 20, 18, 12), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(width: 48, height: 48, alignment: Alignment.center, decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(16)), child: const Text('🥑', style: TextStyle(fontSize: 25))),
            if (constraints.maxWidth >= 1180) ...<Widget>[const SizedBox(width: 12), Expanded(child: Text('My Fridge', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)))],
          ])),
          Expanded(child: NavigationRail(extended: constraints.maxWidth >= 1180, selectedIndex: state.selectedPage, onDestinationSelected: state.selectPage, labelType: constraints.maxWidth >= 1180 ? NavigationRailLabelType.none : NavigationRailLabelType.selected, groupAlignment: -0.8, destinations: _destinations.map((NavigationDestination destination) => NavigationRailDestination(icon: destination.icon, selectedIcon: destination.selectedIcon, label: Text(destination.label))).toList())),
        ])),
        Expanded(child: content),
      ])));
    });
  }
}
