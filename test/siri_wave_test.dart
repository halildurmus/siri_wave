import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:siri_wave/src/ios_7/ios_7_siri_wave.dart';
import 'package:siri_wave/src/ios_9/ios_9_siri_wave.dart';

void main() {
  group('SiriWave', () {
    testWidgets('widget\'s properties should be set correctly',
        (WidgetTester tester) async {
      // Build the SiriWave widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: SiriWave(),
          ),
        ),
      );

      // Find the SizedBox widget.
      final sizedBox = tester.firstWidget<SizedBox>(find.byType(SizedBox));

      expect(sizedBox.height, 180);
      expect(sizedBox.width, 360);

      // Find the BoxDecoration widget.
      final boxDecoration =
          (tester.firstWidget<DecoratedBox>(find.byType(DecoratedBox)))
              .decoration as BoxDecoration;

      expect(boxDecoration.color, Colors.black);
    });

    testWidgets('widget should display the IOS9SiriWave widget by default',
        (WidgetTester tester) async {
      // Build the SiriWave widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: SiriWave(),
          ),
        ),
      );

      // The IOS9SiriWave should exist in the widget tree.
      expect(find.byType(IOS9SiriWave), findsOneWidget);
    });

    testWidgets(
        'widget should display the IOS7SiriWave widget if the siriWaveStyle parameter is set to SiriWaveStyle.ios_7',
        (WidgetTester tester) async {
      // Build the SiriWave widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: SiriWave(
              style: SiriWaveStyle.ios_7,
            ),
          ),
        ),
      );

      // The IOS7SiriWave should exist in the widget tree.
      expect(find.byType(IOS7SiriWave), findsOneWidget);
    });
  });
}
