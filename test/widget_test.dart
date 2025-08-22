// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:food_tracker_flutter/main.dart';

void main() {
  testWidgets('App shows home and opens add-order screen', (WidgetTester tester) async {
    // Build the app wrapped in ProviderScope for Riverpod.
    await tester.pumpWidget(ProviderScope(child: const FoodTrackerApp()));

    // Home screen should show the app title and a FAB with add icon.
    expect(find.text('Food Tracker'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Tap the FAB and navigate to AddOrderScreen.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Add order screen should show its app bar title.
    expect(find.text('Adicionar Pedido'), findsOneWidget);
  });
}
