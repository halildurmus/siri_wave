import 'package:flutter/rendering.dart';

/// A custom painter responsible for rendering a support bar on
/// *iOS 9 Siri-style* waveform.
class IOS9SiriWaveformSupportBarPainter extends CustomPainter {
  /// Creates an instance of [IOS9SiriWaveformSupportBarPainter].
  const IOS9SiriWaveformSupportBarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final maxHeight = size.height / 2;
    final rect = Rect.fromLTWH(0, maxHeight, size.width, 1);
    final shader = LinearGradient(
      colors: [
        const Color(0xFF111111).withValues(alpha: .7),
        const Color(0xFFFFFFFF).withValues(alpha: .7),
        const Color(0xFFFFFFFF).withValues(alpha: .7),
        const Color(0xFF111111).withValues(alpha: .7),
      ],
      stops: const [0, .1, .8, 1],
    ).createShader(rect);
    final paint = Paint()..shader = shader;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(IOS9SiriWaveformSupportBarPainter oldDelegate) => false;
}
