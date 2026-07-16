import 'package:flutter/material.dart';

import 'application/app_state.dart';
import 'core/theme/app_theme.dart';
import 'presentation/app_shell.dart';

class FridgeApp extends StatefulWidget {
  const FridgeApp({super.key});

  @override
  State<FridgeApp> createState() => _FridgeAppState();
}

class _FridgeAppState extends State<FridgeApp> {
  late final AppState _state;

  @override
  void initState() {
    super.initState();
    _state = AppState.seeded();
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _state,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "What's in My Fridge?",
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: _state.themeMode,
          home: AppShell(state: _state),
        );
      },
    );
  }
}
