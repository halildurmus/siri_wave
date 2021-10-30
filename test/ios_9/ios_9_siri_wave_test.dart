import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:siri_wave/src/ios_9/ios_9_siri_wave.dart';
import 'package:siri_wave/src/ios_9/ios_9_siri_wave_painter.dart';
import 'package:siri_wave/src/ios_9/support_line_painter.dart';

void main() {
  group('IOS9SiriWave', () {
    testWidgets('widget\'s properties should be set correctly',
        (WidgetTester tester) async {
      // Build the SiriWave widget.
      await tester.pumpWidget(
        const MaterialApp(
          home: Material(
            child: IOS9SiriWave(
              options: IOS9Options(),
            ),
          ),
        ),
      );

      // Find the IOS9SiriWave widget.
      final ios9SiriWave =
          tester.firstWidget<IOS9SiriWave>(find.byType(IOS9SiriWave));

      expect(ios9SiriWave.options.amplitude, 1);
      expect(ios9SiriWave.speed, .2);
    });

    testWidgets(
        'widget should paint the canvas with SupportLinePainter and IOS9SiriWavePainter',
        (WidgetTester tester) async {
      // Build the SiriWave widget.
      await tester.pumpWidget(
        const MaterialApp(
          home: Material(
            child: IOS9SiriWave(
              options: IOS9Options(),
            ),
          ),
        ),
      );

      // Find the CustomPaint widget.
      final customPaint = tester.firstWidget<CustomPaint>(
        find.descendant(
          of: find.byType(AnimatedBuilder),
          matching: find.byType(CustomPaint),
        ),
      );

      expect(customPaint.painter, isA<SupportLinePainter>());
      expect(customPaint.foregroundPainter, isA<IOS9SiriWavePainter>());
    });

    testWidgets(
        'widget should only paint the canvas with SupportLinePainter if the amplitude is 0',
        (WidgetTester tester) async {
      // Build the SiriWave widget.
      await tester.pumpWidget(
        const MaterialApp(
          home: Material(
            child: IOS9SiriWave(
              options: IOS9Options(amplitude: 0),
            ),
          ),
        ),
      );

      // Find the CustomPaint widget.
      final customPaint = tester.firstWidget<CustomPaint>(
        find.descendant(
          of: find.byType(AnimatedBuilder),
          matching: find.byType(CustomPaint),
        ),
      );

      expect(customPaint.painter, isA<SupportLinePainter>());
      expect(customPaint.foregroundPainter, null);
    });
  });
}
