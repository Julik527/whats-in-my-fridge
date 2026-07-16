import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whats_in_my_fridge/app.dart';

void main() {
  testWidgets('FridgeApp starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const FridgeApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Übersicht'), findsWidgets);
  });
}
