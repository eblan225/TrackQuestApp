// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:track_quest_app/main.dart';

void main() {
  testWidgets('adds independent Elden Ring playthroughs', (tester) async {
    await tester.pumpWidget(const TrackQuestApp());

    await tester.tap(find.text('Add game'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Elden Ring'));
    await tester.pumpAndSettle();

    expect(find.text('Elden Ring'), findsOneWidget);
    expect(find.text('0% complete'), findsOneWidget);
  });
}
