import 'package:flutter/rendering.dart';

class SupportLinePainter extends CustomPainter {
  const SupportLinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, size.height / 2, size.width, 1);
    final shader = const LinearGradient(
      colors: [
        Color(0xFF111111),
        Color(0xFFFFFFFF),
        Color(0xFFFFFFFF),
        Color(0xFF111111)
      ],
      stops: [0, .1, .8, 1],
    ).createShader(
      Rect.fromPoints(Offset(0, size.height / 2), Offset(size.width, 1)),
    );
    final Paint paint = Paint()..shader = shader;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(SupportLinePainter oldDelegate) => false;
}
