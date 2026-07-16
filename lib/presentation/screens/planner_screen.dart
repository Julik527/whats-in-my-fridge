import 'package:flutter/material.dart';

import '../../application/app_state.dart';
import '../../domain/models.dart';
import '../widgets/common_widgets.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({required this.state, super.key});
  final AppState state;
  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  final Map<int, String?> _selectedRecipes = <int, String?>{};
  static const List<String> _days = <String>['Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag', 'Sonntag'];
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const PageHeader(title: 'Wochenplaner', subtitle: 'Plane deine Mahlzeiten und nutze Vorräte gezielter.'),
      Expanded(child: ListView.separated(padding: const EdgeInsets.fromLTRB(24, 0, 24, 32), itemCount: _days.length, separatorBuilder: (_, __) => const SizedBox(height: 12), itemBuilder: (BuildContext context, int index) {
        final String? selectedId = _selectedRecipes[index];
        final Recipe? selected = selectedId == null ? null : widget.state.recipes.firstWhere((Recipe recipe) => recipe.id == selectedId);
        return SurfaceCard(child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          final Widget day = SizedBox(width: 125, child: Text(_days[index], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)));
          final Widget picker = DropdownButtonFormField<String?>(initialValue: selectedId, decoration: const InputDecoration(labelText: 'Abendessen', prefixIcon: Icon(Icons.restaurant_menu)), items: <DropdownMenuItem<String?>>[const DropdownMenuItem<String?>(value: null, child: Text('Noch nicht geplant')), ...widget.state.recipes.map((Recipe recipe) => DropdownMenuItem<String?>(value: recipe.id, child: Text('${recipe.emoji}  ${recipe.title}')))], onChanged: (String? value) => setState(() => _selectedRecipes[index] = value));
          if (constraints.maxWidth < 620) return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[day, const SizedBox(height: 12), picker, if (selected != null) ...<Widget>[const SizedBox(height: 10), Text('${selected.minutes} Minuten • ${selected.matchPercent}% der Zutaten vorhanden')]]);
          return Row(children: <Widget>[day, const SizedBox(width: 18), Expanded(child: picker), if (selected != null) ...<Widget>[const SizedBox(width: 18), Text('${selected.matchPercent}% Match')]]);
        }));
      })),
    ]);
  }
}
