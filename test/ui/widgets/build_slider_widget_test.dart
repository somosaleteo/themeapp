import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:themeapp/ui/widgets/build_slider_widget.dart';

// Mock para el callback
class MockOnChanged extends Mock {
  void call(double value);
}

void main() {
  group('BuildSliderWidget', () {
    late MockOnChanged mockOnChanged;

    setUp(() {
      mockOnChanged = MockOnChanged();
    });

    testWidgets('renderiza correctamente el label y el valor', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BuildSliderWidget(
              label: 'R',
              value: 0.5,
              color: Colors.red,
              onChanged: mockOnChanged.call,
            ),
          ),
        ),
      );

      expect(find.text('R'), findsOneWidget);
      expect(
        find.text('128'),
        findsOneWidget,
      ); // 0.5 * 255 = 127.5 → ceil = 128
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('ejecuta onChanged al mover el slider', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BuildSliderWidget(
              label: 'G',
              value: 0.2,
              color: Colors.green,
              onChanged: mockOnChanged.call,
            ),
          ),
        ),
      );

      final Slider slider = tester.widget<Slider>(find.byType(Slider));
      // Disparar el callback manualmente
      slider.onChanged?.call(0.3);

      verify(() => mockOnChanged(0.3)).called(1);
    });
  });
}
