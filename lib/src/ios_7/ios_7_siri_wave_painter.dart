import 'dart:math' as math;

import 'package:flutter/animation.dart' show AnimationController;
import 'package:flutter/rendering.dart';

import '../models/siri_wave_controller.dart';

// Describes the curve properties will be used by `IOS7SiriWavePainter`.
class _IOS7SiriWaveCurve {
  const _IOS7SiriWaveCurve({
    required this.attenuation,
    required this.width,
    required this.opacity,
  });

  final double attenuation;
  final double width;
  final double opacity;

  @override
  String toString() =>
      '_IOS7SiriWaveCurve(attenuation: $attenuation, lineWidth: $width, opacity: $opacity)';
}

class IOS7SiriWavePainter extends CustomPainter {
  IOS7SiriWavePainter({
    required this.animationController,
    required this.controller,
    required this.frequency,
  }) : super(repaint: animationController);

  final AnimationController animationController;
  final SiriWaveController controller;
  final int frequency;

  static const double _amplitudeFactor = .6;
  static const int _attenuationFactor = 4;
  static const _curves = [
    _IOS7SiriWaveCurve(attenuation: -2, width: 1, opacity: .1),
    _IOS7SiriWaveCurve(attenuation: -6, width: 1, opacity: .2),
    _IOS7SiriWaveCurve(attenuation: 4, width: 1, opacity: .4),
    _IOS7SiriWaveCurve(attenuation: 2, width: 1, opacity: .6),
    _IOS7SiriWaveCurve(attenuation: 1, width: 1.5, opacity: 1),
  ];
  static const double _graphX = 2;
  static const double _pixelDepth = .02;
  static const _waveColor = Color(0xFFFFFFFF);

  double _phase = 0;

  num _globalAttenuationFactor(num x) => math.pow(
      _attenuationFactor /
          (_attenuationFactor + math.pow(x, _attenuationFactor)),
      _attenuationFactor);

  double _xPos(double i, Size size) =>
      size.width * ((i + _graphX) / (_graphX * 2));

  double _yPos(double i, double attenuation, double maxHeight) =>
      (_amplitudeFactor *
          (_globalAttenuationFactor(i) *
              (maxHeight * controller.amplitude) *
              (1 / attenuation) *
              math.sin(frequency * i - _phase)));

  @override
  void paint(Canvas canvas, Size size) {
    final maxHeight = size.height / 2;

    // Interpolate amplitude and speed values.
    controller.lerp();

    for (var curve in _curves) {
      final Path path = Path();
      path.moveTo(0, maxHeight);
      // Cycle the graph from -X to +X every pixelDepth and draw the line
      for (var i = -_graphX; i <= _graphX; i += _pixelDepth) {
        final x = _xPos(i, size);
        final y = maxHeight + _yPos(i, curve.attenuation, maxHeight);
        path.lineTo(x, y);
      }

      final paint = Paint()
        ..color = _waveColor.withOpacity(curve.opacity)
        ..strokeWidth = curve.width
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, paint);
    }

    _phase = (_phase + (math.pi / 2) * controller.speed) % (2 * math.pi);
  }

  @override
  bool shouldRepaint(IOS7SiriWavePainter oldDelegate) =>
      oldDelegate.controller.amplitude != controller.amplitude ||
      oldDelegate.controller.speed != controller.speed ||
      oldDelegate.frequency != frequency;
}
