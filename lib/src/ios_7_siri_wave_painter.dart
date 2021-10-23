import 'dart:math' as math;

import 'package:flutter/rendering.dart';

class _IOS7Curve {
  const _IOS7Curve({
    required this.attenuation,
    required this.lineWidth,
    required this.opacity,
  });

  final double attenuation;
  final double lineWidth;
  final double opacity;
}

class IOS7SiriWavePainter extends CustomPainter {
  IOS7SiriWavePainter({
    required this.amplitude,
    required this.frequency,
    required this.phase,
  });

  final double amplitude;
  final int frequency;
  final double phase;

  static const double kAmplitudeFactor = .6;
  static const int kAttenuationFactor = 4;
  static const kCurves = [
    _IOS7Curve(attenuation: -2, lineWidth: 1, opacity: .1),
    _IOS7Curve(attenuation: -6, lineWidth: 1, opacity: .2),
    _IOS7Curve(attenuation: 4, lineWidth: 1, opacity: .4),
    _IOS7Curve(attenuation: 2, lineWidth: 1, opacity: .6),
    _IOS7Curve(attenuation: 1, lineWidth: 1.5, opacity: 1),
  ];
  static const double kGraphX = 2;
  static const double kPixelDepth = .02;
  static const kWaveColor = Color(0xFFFFFFFF);

  num _globalAttenuationFactor(num x) => math.pow(
      kAttenuationFactor /
          (kAttenuationFactor + math.pow(x, kAttenuationFactor)),
      kAttenuationFactor);

  double _xPos(double i, Size size) =>
      size.width * ((i + kGraphX) / (kGraphX * 2));

  double _yPos(double i, double attenuation, double maxHeight) =>
      (kAmplitudeFactor *
          (_globalAttenuationFactor(i) *
              (maxHeight * amplitude) *
              (1 / attenuation) *
              math.sin(frequency * i - phase)));

  @override
  void paint(Canvas canvas, Size size) {
    final maxHeight = size.height / 2;

    for (var curve in kCurves) {
      final Path path = Path();
      path.moveTo(0, maxHeight);
      // Cycle the graph from -X to +X every pixelDepth and draw the line
      for (var i = -kGraphX; i <= kGraphX; i += kPixelDepth) {
        final x = _xPos(i, size);
        final y = maxHeight + _yPos(i, curve.attenuation, maxHeight);
        path.lineTo(x, y);
      }

      final paint = Paint()
        ..color = kWaveColor.withOpacity(curve.opacity)
        ..strokeWidth = curve.lineWidth
        ..style = PaintingStyle.stroke;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(IOS7SiriWavePainter oldDelegate) =>
      oldDelegate.amplitude != amplitude ||
      oldDelegate.frequency != frequency ||
      oldDelegate.phase != phase;
}
