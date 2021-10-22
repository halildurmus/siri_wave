import 'package:flutter/rendering.dart';

import 'painter_controller.dart';

class WavePainter extends CustomPainter {
  WavePainter(
    this.controller,
    this.maxHeight,
    this.width,
  ) : super(repaint: controller);

  final PainterController controller;
  final double maxHeight;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    for (final path in controller.paths) {
      final paint = Paint()
        ..blendMode = BlendMode.lighten
        ..color = controller.color;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return true;
    // return oldDelegate.controller != controller;
  }
}
