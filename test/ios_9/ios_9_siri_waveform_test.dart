import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siri_wave/siri_wave.dart';

void main() {
  group('IOS9SiriWaveform', () {
    testWidgets("widget's properties should be set correctly", (tester) async {
      // Build the IOS9SiriWaveform widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: IOS9SiriWaveform(controller: IOS9SiriWaveformController()),
          ),
        ),
      );

      // Find the IOS9SiriWaveform widget.
      final ios9SiriWaveform = tester.firstWidget<IOS9SiriWaveform>(
        find.byType(IOS9SiriWaveform),
      );
      expect(ios9SiriWaveform.controller.amplitude, 1);
      expect(ios9SiriWaveform.controller.speed, .2);
    });

    testWidgets(
      'widget should paint the canvas with IOS9SiriWaveformSupportBarPainter '
      'and IOS9SiriWaveformPainter',
      (tester) async {
        // Build the IOS9SiriWaveform widget.
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: IOS9SiriWaveform(controller: IOS9SiriWaveformController()),
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
        expect(customPaint.painter, isA<IOS9SiriWaveformSupportBarPainter>());
        expect(customPaint.foregroundPainter, isA<IOS9SiriWaveformPainter>());
      },
    );

    testWidgets('widget should only paint the canvas with '
        'IOS9SiriWaveformSupportBarPainter if the amplitude is 0', (
      tester,
    ) async {
      // Build the IOS9SiriWaveform widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: IOS9SiriWaveform(
              controller: IOS9SiriWaveformController(amplitude: 0),
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
      expect(customPaint.painter, isA<IOS9SiriWaveformSupportBarPainter>());
      expect(customPaint.foregroundPainter, null);
    });
  });
}
