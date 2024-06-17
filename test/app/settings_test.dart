import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:black_tax_and_white_benefits/app/features/settings/settings_icon_button.dart';
import 'package:black_tax_and_white_benefits/app/features/text_size/text_size_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

void main() {
  group('Test Settings view', () {
    testWidgets('open view', (tester) async {
      // Load app widget.
      await tester.pumpApp(const App());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(SettingsIconButton));
      await tester.pumpAndSettle();

      // Exit Details screen
      await tester.pageBack();
      await tester.pumpAndSettle();
    });
  });
  group('Test adjust Text Size', () {
    setUpAll(() {
      registerFallbackValue(1.0);
    });
    testWidgets('increase', (tester) async {
      // Load app widget.
      await tester.pumpApp(const App());
      await tester.pumpAndSettle();

      final element = tester.element(find.byType(App));
      final container = ProviderScope.containerOf(element);

      addTearDown(container.dispose);
      final listener = ProviderListener<double>();

      container.listen<double>(
        textSizeControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      // Navigate to settings.
      await tester.tap(find.byType(SettingsIconButton));
      await tester.pumpAndSettle();

      // Tap text increase button
      await tester.tap(find.byIcon(Icons.text_increase_rounded));
      await tester.pumpAndSettle();

      await container.read(textSizeControllerProvider);

      // verify
      verifyInOrder([
        () => listener(null, 1.0),
        () => listener(1.0, 1.28),
      ]);
      verifyNoMoreInteractions(listener);

      // Exit Details screen
      await tester.pageBack();
      await tester.pumpAndSettle();
    });
    testWidgets('decrease', (tester) async {
      // Load app widget.
      await tester.pumpApp(const App());
      await tester.pumpAndSettle();

      final element = tester.element(find.byType(App));
      final container = ProviderScope.containerOf(element);

      addTearDown(container.dispose);
      final listener = ProviderListener<double>();

      container.listen<double>(
        textSizeControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      // Navigate to settings.
      await tester.tap(find.byType(SettingsIconButton));
      await tester.pumpAndSettle();

      // Tap text decrease button
      await tester.tap(find.byIcon(Icons.text_decrease_rounded));
      await tester.pumpAndSettle();

      await container.read(textSizeControllerProvider);

      // verify
      verifyInOrder([
        () => listener(null, 1.0),
        () => listener(1.0, 0.78125),
      ]);
      verifyNoMoreInteractions(listener);

      // Exit Details screen
      await tester.pageBack();
      await tester.pumpAndSettle();
    });
  });
}
