import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({required this.title, required this.subtitle, this.action, super.key});
  final String title;
  final String subtitle;
  final Widget? action;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.6)),
          const SizedBox(height: 6),
          Text(subtitle, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ])),
        if (action != null) ...<Widget>[const SizedBox(width: 16), action!],
      ]),
    );
  }
}

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({required this.child, this.padding = const EdgeInsets.all(18), this.onTap, super.key});
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22), side: BorderSide(color: scheme.outlineVariant)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(onTap: onTap, child: Padding(padding: padding, child: child)),
    );
  }
}

class MetricCard extends StatelessWidget {
  const MetricCard({required this.label, required this.value, required this.icon, required this.accent, super.key});
  final String label;
  final String value;
  final IconData icon;
  final Color accent;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 210, child: SurfaceCard(child: Row(children: <Widget>[
      Container(width: 48, height: 48, decoration: BoxDecoration(color: accent.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(16)), child: Icon(icon, color: accent)),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 2),
        Text(label, maxLines: 2, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
      ])),
    ])));
  }
}

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({required this.icon, required this.title, required this.message, super.key});
  final IconData icon;
  final String title;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
      const SizedBox(height: 14),
      Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      Text(message, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
    ])));
  }
}
