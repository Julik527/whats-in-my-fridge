import 'package:flutter/material.dart';

import '../../application/app_state.dart';
import '../widgets/common_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({required this.state, super.key});
  final AppState state;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const PageHeader(title: 'Einstellungen', subtitle: 'Passe Darstellung und Verhalten der Demo-App an.'),
      Padding(padding: const EdgeInsets.fromLTRB(24, 0, 24, 14), child: SurfaceCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text('Darstellung', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 14),
        SegmentedButton<ThemeMode>(segments: const <ButtonSegment<ThemeMode>>[ButtonSegment<ThemeMode>(value: ThemeMode.system, icon: Icon(Icons.settings_suggest_outlined), label: Text('System')), ButtonSegment<ThemeMode>(value: ThemeMode.light, icon: Icon(Icons.light_mode_outlined), label: Text('Hell')), ButtonSegment<ThemeMode>(value: ThemeMode.dark, icon: Icon(Icons.dark_mode_outlined), label: Text('Dunkel'))], selected: <ThemeMode>{state.themeMode}, onSelectionChanged: (Set<ThemeMode> values) => state.setThemeMode(values.first)),
      ]))),
      Padding(padding: const EdgeInsets.fromLTRB(24, 0, 24, 14), child: SurfaceCard(child: Column(children: <Widget>[
        const ListTile(contentPadding: EdgeInsets.zero, leading: Icon(Icons.notifications_outlined), title: Text('Ablaufwarnungen'), subtitle: Text('Demo: Warnungen sieben Tage vorher'), trailing: Switch(value: true, onChanged: null)),
        const Divider(),
        ListTile(contentPadding: EdgeInsets.zero, leading: const Icon(Icons.cloud_off_outlined), title: const Text('Lokaler Demo-Modus'), subtitle: const Text('Alle Daten bleiben nur während der geöffneten Sitzung erhalten.'), trailing: Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)),
      ]))),
      Padding(padding: const EdgeInsets.fromLTRB(24, 0, 24, 32), child: SurfaceCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text("What's in My Fridge?", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        const Text('Professionelle Flutter-Demo für Inventar, Rezeptvorschläge, Wochenplanung und Einkaufsliste.'),
        const SizedBox(height: 14),
        Text('Version 1.0.0 • Erstellt für Julik527', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
      ]))),
    ]));
  }
}
