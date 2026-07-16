import 'package:flutter/material.dart';

import '../../application/app_state.dart';
import '../../domain/models.dart';
import '../widgets/common_widgets.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({required this.state, super.key});
  final AppState state;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(children: <Widget>[
      const PageHeader(title: 'Rezeptideen', subtitle: 'Vorschläge auf Basis deiner vorhandenen Lebensmittel.'),
      Expanded(child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        final int columns = constraints.maxWidth >= 1150 ? 3 : constraints.maxWidth >= 700 ? 2 : 1;
        return GridView.builder(padding: const EdgeInsets.fromLTRB(24, 0, 24, 32), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: columns == 1 ? 1.55 : 1.05), itemCount: state.recipes.length, itemBuilder: (BuildContext context, int index) {
          final Recipe recipe = state.recipes[index];
          return SurfaceCard(padding: EdgeInsets.zero, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Container(height: 122, width: double.infinity, alignment: Alignment.center, decoration: BoxDecoration(gradient: LinearGradient(colors: <Color>[scheme.primaryContainer, scheme.tertiaryContainer])), child: Text(recipe.emoji, style: const TextStyle(fontSize: 60))),
            Expanded(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Row(children: <Widget>[Expanded(child: Text(recipe.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800))), IconButton(tooltip: 'Favorit', onPressed: () => state.toggleRecipeFavorite(recipe.id), icon: Icon(recipe.isFavorite ? Icons.favorite : Icons.favorite_border, color: recipe.isFavorite ? Colors.pink : null))]),
              Text(recipe.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurfaceVariant)),
              const Spacer(),
              Wrap(spacing: 8, runSpacing: 8, children: <Widget>[Chip(avatar: const Icon(Icons.timer_outlined, size: 17), label: Text('${recipe.minutes} Min.')), Chip(avatar: const Icon(Icons.inventory_2_outlined, size: 17), label: Text('${recipe.matchPercent}% vorhanden'))]),
              const SizedBox(height: 12),
              Text(recipe.ingredients.join(' • '), maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall),
            ]))),
          ]));
        });
      })),
    ]);
  }
}
