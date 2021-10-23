import 'package:flutter/rendering.dart';

import 'painter_controller.dart';

class WavePainter extends CustomPainter {
  WavePainter(this.controller) : super(repaint: controller);

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
  bool shouldRepaint(WavePainter oldDelegate) => true;
}
