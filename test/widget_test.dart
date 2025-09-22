// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:real_pet_app/main.dart';

void main() {
  testWidgets('Digital Pet App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: DigitalPetApp()));

    // Verify that our app shows the pet name.
    expect(find.text('Name: Your Pet'), findsOneWidget);
    expect(find.text('Happiness Level: 50'), findsOneWidget);

    // Tap the 'Play with Your Pet' button and trigger a frame.
    await tester.tap(find.text('Play with Your Pet'));
    await tester.pump();

    // Verify that happiness level has increased.
    expect(find.text('Happiness Level: 60'), findsOneWidget);
  });
}
