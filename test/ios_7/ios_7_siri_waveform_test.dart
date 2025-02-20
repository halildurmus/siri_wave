import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siri_wave/siri_wave.dart';

void main() {
  group('IOS7SiriWaveform', () {
    testWidgets("widget's properties should be set correctly", (tester) async {
      // Build the IOS7SiriWaveform widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: IOS7SiriWaveform(controller: IOS7SiriWaveformController()),
          ),
        ),
      );

      // Find the IOS7SiriWaveform widget.
      final ios7SiriWaveform = tester.firstWidget<IOS7SiriWaveform>(
        find.byType(IOS7SiriWaveform),
      );
      final controller = ios7SiriWaveform.controller;
      expect(controller.amplitude, 1);
      expect(controller.color, Colors.white);
      expect(controller.frequency, 6);
      expect(controller.speed, .2);
    });

    testWidgets('widget should paint the canvas with IOS7SiriWaveformPainter', (
      tester,
    ) async {
      // Build the IOS7SiriWaveform widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: IOS7SiriWaveform(controller: IOS7SiriWaveformController()),
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
      expect(customPaint.painter, isA<IOS7SiriWaveformPainter>());
    });
  });
}
