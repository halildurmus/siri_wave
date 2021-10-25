import 'dart:math' as math;

import 'package:flutter/animation.dart' show AnimationController;
import 'package:flutter/rendering.dart';

class _IOS7SiriWaveCurve {
  const _IOS7SiriWaveCurve({
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
    required this.controller,
  }) : super(repaint: controller);

  final double amplitude;
  final int frequency;
  final AnimationController controller;

  static const double _kAmplitudeFactor = .6;
  static const int _kAttenuationFactor = 4;
  static const _kCurves = [
    _IOS7SiriWaveCurve(attenuation: -2, lineWidth: 1, opacity: .1),
    _IOS7SiriWaveCurve(attenuation: -6, lineWidth: 1, opacity: .2),
    _IOS7SiriWaveCurve(attenuation: 4, lineWidth: 1, opacity: .4),
    _IOS7SiriWaveCurve(attenuation: 2, lineWidth: 1, opacity: .6),
    _IOS7SiriWaveCurve(attenuation: 1, lineWidth: 1.5, opacity: 1),
  ];
  static const double _kGraphX = 2;
  static const double _kPixelDepth = .02;
  static const _kWaveColor = Color(0xFFFFFFFF);

  double _phase = 0;

  num _globalAttenuationFactor(num x) => math.pow(
      _kAttenuationFactor /
          (_kAttenuationFactor + math.pow(x, _kAttenuationFactor)),
      _kAttenuationFactor);

  double _xPos(double i, Size size) =>
      size.width * ((i + _kGraphX) / (_kGraphX * 2));

  double _yPos(double i, double attenuation, double maxHeight) =>
      (_kAmplitudeFactor *
          (_globalAttenuationFactor(i) *
              (maxHeight * amplitude) *
              (1 / attenuation) *
              math.sin(frequency * i - _phase)));

  @override
  void paint(Canvas canvas, Size size) {
    final maxHeight = size.height / 2;

    for (var curve in _kCurves) {
      final Path path = Path();
      path.moveTo(0, maxHeight);
      // Cycle the graph from -X to +X every pixelDepth and draw the line
      for (var i = -_kGraphX; i <= _kGraphX; i += _kPixelDepth) {
        final x = _xPos(i, size);
        final y = maxHeight + _yPos(i, curve.attenuation, maxHeight);
        path.lineTo(x, y);
      }

      final paint = Paint()
        ..color = _kWaveColor.withOpacity(curve.opacity)
        ..strokeWidth = curve.lineWidth
        ..style = PaintingStyle.stroke;

      canvas.drawPath(path, paint);
    }

    _phase = (_phase + (math.pi / 2) * .2) % (2 * math.pi);
  }

  @override
  bool shouldRepaint(IOS7SiriWavePainter oldDelegate) =>
      oldDelegate.amplitude != amplitude || oldDelegate.frequency != frequency;
}
