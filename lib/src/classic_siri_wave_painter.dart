import 'dart:math' as math;

import 'package:flutter/rendering.dart';

class _ClassicCurve {
  const _ClassicCurve({
    required this.attenuation,
    required this.lineWidth,
    required this.opacity,
  });

  final double attenuation;
  final double lineWidth;
  final double opacity;
}

class ClassicSiriWavePainter extends CustomPainter {
  ClassicSiriWavePainter({required this.amplitude, required this.phase});

  final double amplitude;
  final double phase;

  static const double kAmplitudeFactor = .6;
  static const int kAttenuationFactor = 4;
  static const kColor = Color(0xFFFFFFFF);
  static const kCurves = [
    _ClassicCurve(attenuation: -2, lineWidth: 1, opacity: .1),
    _ClassicCurve(attenuation: -6, lineWidth: 1, opacity: .2),
    _ClassicCurve(attenuation: 4, lineWidth: 1, opacity: .4),
    _ClassicCurve(attenuation: 2, lineWidth: 1, opacity: .6),
    _ClassicCurve(attenuation: 1, lineWidth: 1.5, opacity: 1),
  ];
  static const int kFrequency = 6;
  static const double kGraphX = 2;
  static const double kPixelDepth = .02;

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
              math.sin(kFrequency * i - phase)));

  @override
  void paint(Canvas canvas, Size size) {
    final double maxHeight = size.height / 2;
    // final paint = Paint()..blendMode = BlendMode.dstOut;
    // canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    for (var curve in kCurves) {
      final paint = Paint()
        ..color = kColor.withOpacity(curve.opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = curve.lineWidth;

      final Path path = Path();
      path.moveTo(0, maxHeight);
      // Cycle the graph from -X to +X every pixelDepth and draw the line
      for (var i = -kGraphX; i <= kGraphX; i += kPixelDepth) {
        path.lineTo(
            _xPos(i, size), maxHeight + _yPos(i, curve.attenuation, maxHeight));
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(ClassicSiriWavePainter oldDelegate) => true;
}
