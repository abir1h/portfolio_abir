// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio/data/profile.dart';
import 'package:portfolio/portfolio_page.dart';

void main() {
  testWidgets('Portfolio hero renders primary identity text', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: PortfolioPage(data: PortfolioData.abir)),
    );
    await tester.pump(const Duration(seconds: 3));
    expect(
      find.text('Abir Rahman', findRichText: true),
      findsOneWidget,
    );
    expect(
      find.text('Software Engineer (Flutter Developer)', findRichText: true),
      findsOneWidget,
    );
  });
}
