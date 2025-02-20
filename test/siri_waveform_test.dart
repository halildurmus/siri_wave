import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siri_wave/siri_wave.dart';

void main() {
  group('SiriWaveform', () {
    testWidgets("widget's properties should be set correctly", (tester) async {
      // Build the SiriWaveform widget.
      await tester.pumpWidget(
        MaterialApp(home: Material(child: SiriWaveform.ios7())),
      );

      // Find the SizedBox widget.
      final sizedBox = tester.firstWidget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, 180);
      expect(sizedBox.width, 360);
    });

    testWidgets(
      '.ios7 constructor should display the IOS7SiriWaveform widget',
      (tester) async {
        // Build the SiriWave widget.
        await tester.pumpWidget(
          MaterialApp(home: Material(child: SiriWaveform.ios7())),
        );

        // The IOS7SiriWaveform widget should exist in the widget tree.
        expect(find.byType(IOS7SiriWaveform), findsOneWidget);
      },
    );

    testWidgets(
      '.ios9 constructor should display the IOS9SiriWaveform widget',
      (tester) async {
        // Build the SiriWave widget.
        await tester.pumpWidget(
          MaterialApp(home: Material(child: SiriWaveform.ios9())),
        );

        // The IOS9SiriWaveform widget should exist in the widget tree.
        expect(find.byType(IOS9SiriWaveform), findsOneWidget);
      },
    );
  });
}
