import 'package:flutter/rendering.dart';

import 'painter_controller.dart';

class IOS9SiriWavePainter extends CustomPainter {
  IOS9SiriWavePainter(this.controller) : super(repaint: controller);

  final PainterController controller;

  @override
  void paint(Canvas canvas, Size size) {
    for (final wave in controller.waves) {
      final paint = Paint()
        ..blendMode = BlendMode.plus
        ..color = wave.color;
      canvas.drawPath(wave.path, paint);
    }
  }

  @override
  bool shouldRepaint(IOS9SiriWavePainter oldDelegate) => true;
}
