import 'package:flutter/rendering.dart';

class SupportLinePainter extends CustomPainter {
  const SupportLinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, size.height / 2, size.width, 1);
    final shader = LinearGradient(
      colors: [
        const Color(0xFF111111).withOpacity(.7),
        const Color(0xFFFFFFFF).withOpacity(.7),
        const Color(0xFFFFFFFF).withOpacity(.7),
        const Color(0xFF111111).withOpacity(.7)
      ],
      stops: const [0, .1, .8, 1],
    ).createShader(rect);
    final paint = Paint()..shader = shader;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(SupportLinePainter oldDelegate) => false;
}
