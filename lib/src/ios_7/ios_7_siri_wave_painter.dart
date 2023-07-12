import 'dart:math' as math;

import 'package:flutter/animation.dart' show AnimationController;
import 'package:flutter/rendering.dart';

import '../models/siri_wave_controller.dart';

class IOS7SiriWavePainter extends CustomPainter {
  IOS7SiriWavePainter({
    required this.animationController,
    required this.controller,
  }) : super(repaint: animationController);

  final AnimationController animationController;
  final SiriWaveController controller;

  static const _amplitudeFactor = .6;
  static const _attenuationFactor = 4;
  static const _curves = [
    _IOS7SiriWaveCurve(attenuation: -2, width: 1, opacity: .1),
    _IOS7SiriWaveCurve(attenuation: -6, width: 1, opacity: .2),
    _IOS7SiriWaveCurve(attenuation: 4, width: 1, opacity: .4),
    _IOS7SiriWaveCurve(attenuation: 2, width: 1, opacity: .6),
    _IOS7SiriWaveCurve(attenuation: 1, width: 1.5, opacity: 1),
  ];
  static const _graphX = 2.0;
  static const _pixelDepth = .02;

  double _phase = 0;

  num _globalAttenuationFactor(num x) => math.pow(
      _attenuationFactor /
          (_attenuationFactor + math.pow(x, _attenuationFactor)),
      _attenuationFactor);

  double _xPos(double i, Size size) =>
      size.width * ((i + _graphX) / (_graphX * 2));

  double _yPos(double i, double attenuation, double maxHeight) =>
      _amplitudeFactor *
      (_globalAttenuationFactor(i) *
          (maxHeight * controller.amplitude) *
          (1 / attenuation) *
          math.sin(controller.frequency * i - _phase));

  @override
  void paint(Canvas canvas, Size size) {
    final maxHeight = size.height / 2;

    // Interpolate amplitude and speed values.
    controller.lerp();

    for (final curve in _curves) {
      final path = Path()..moveTo(0, maxHeight);
      // Cycle the graph from -X to +X every pixelDepth and draw the line
      for (var i = -_graphX; i <= _graphX; i += _pixelDepth) {
        final x = _xPos(i, size);
        final y = maxHeight + _yPos(i, curve.attenuation, maxHeight);
        path.lineTo(x, y);
      }

      final paint = Paint()
        ..color = controller.color.withOpacity(curve.opacity)
        ..strokeWidth = curve.width
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, paint);
    }

    _phase = (_phase + (math.pi / 2) * controller.speed) % (2 * math.pi);
  }

  @override
  bool shouldRepaint(IOS7SiriWavePainter oldDelegate) =>
      oldDelegate.controller.amplitude != controller.amplitude ||
      oldDelegate.controller.frequency != controller.frequency ||
      oldDelegate.controller.speed != controller.speed;
}

/// Describes the curve properties will be used by [IOS7SiriWavePainter].
class _IOS7SiriWaveCurve {
  const _IOS7SiriWaveCurve({
    required this.attenuation,
    required this.opacity,
    required this.width,
  });

  final double attenuation;
  final double opacity;
  final double width;
}
