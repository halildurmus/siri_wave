import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:siri_wave/src/ios_7/ios_7_siri_wave.dart';
import 'package:siri_wave/src/ios_7/ios_7_siri_wave_painter.dart';

void main() {
  group('IOS7SiriWave', () {
    testWidgets('widget\'s properties should be set correctly',
        (WidgetTester tester) async {
      // Build the SiriWave widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: IOS7SiriWave(
              controller: SiriWaveController(),
            ),
          ),
        ),
      );

      // Find the IOS7SiriWave widget.
      final ios7SiriWave =
          tester.firstWidget<IOS7SiriWave>(find.byType(IOS7SiriWave));

      expect(ios7SiriWave.frequency, 6);
      expect(ios7SiriWave.controller.amplitude, 1);
      expect(ios7SiriWave.controller.speed, .2);
    });

    testWidgets('widget should paint the canvas with IOS7SiriWavePainter',
        (WidgetTester tester) async {
      // Build the SiriWave widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: IOS7SiriWave(
              controller: SiriWaveController(),
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

      expect(customPaint.painter, isA<IOS7SiriWavePainter>());
    });
  });
}
