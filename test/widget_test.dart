// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:blocks_puzzle/main.dart';
import 'package:blocks_puzzle/routes/game_home.dart';
import 'package:blocks_puzzle/routes/splash.dart';
import 'package:blocks_puzzle/widgets/game_over.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Main page contains SplashScreen', (WidgetTester tester) async {
    await tester.pumpWidget(BlocksPuzzleApp());

    expect(find.byWidgetPredicate((Widget widget) => widget is SplashScreen),
        findsOneWidget);
    expect(find.byWidgetPredicate((Widget widget) => widget is GameScreen),
        findsNothing);
    expect(find.byWidgetPredicate((Widget widget) => widget is GameOverPopup),
        findsNothing);
  });

  testWidgets('SplashScreen components', (WidgetTester tester) async {
    await tester.pumpWidget(BlocksPuzzleApp());

    // Verify that our counter starts at 0.
    expect(find.byWidgetPredicate((Widget widget) => widget is SplashScreen),
        findsOneWidget);
    expect(find.text('\u{1F171}\u{1F17B}\u{1F17E}\u{1F172}\u{1F17A}\u{1F189}'),
        findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    /* await tester.tap(find.byWidgetPredicate((Widget widget) {
      if (widget is FloatingActionButton) widget.onPressed;
      return true;
    }));
    await tester.pump(); */
  });
}
