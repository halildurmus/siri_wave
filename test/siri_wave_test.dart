// Copyright (c) 2023, Halil Durmus. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siri_wave/siri_wave.dart';

void main() {
  group('SiriWave', () {
    testWidgets("widget's properties should be set correctly", (tester) async {
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
    });

    testWidgets('widget should display the IOS9SiriWave widget by default',
        (tester) async {
      // Build the SiriWave widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: SiriWave(),
          ),
        ),
      );

      // The IOS9SiriWave widget should exist in the widget tree.
      expect(find.byType(IOS9SiriWave), findsOneWidget);
    });

    testWidgets(
        'widget should display the IOS7SiriWave widget if the siriWaveStyle parameter is set to SiriWaveStyle.ios_7',
        (tester) async {
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

      // The IOS7SiriWave widget should exist in the widget tree.
      expect(find.byType(IOS7SiriWave), findsOneWidget);
    });
  });
}
