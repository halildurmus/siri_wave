// Copyright (c) 2023, Halil Durmus. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siri_wave/siri_wave.dart';

void main() {
  group('IOS7SiriWave', () {
    testWidgets("widget's properties should be set correctly", (tester) async {
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
      final controller = ios7SiriWave.controller;
      expect(controller.amplitude, 1);
      expect(controller.color, Colors.white);
      expect(controller.frequency, 6);
      expect(controller.speed, .2);
    });

    testWidgets('widget should paint the canvas with IOS7SiriWavePainter',
        (tester) async {
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
