import 'dart:math' as math;

import 'package:flutter/animation.dart' show AnimationController;
import 'package:flutter/rendering.dart';

import 'ios7_options.dart';

class _IOS7SiriWaveCurve {
  const _IOS7SiriWaveCurve({
    required this.attenuation,
    required this.lineWidth,
    required this.opacity,
  });

  final double attenuation;
  final double lineWidth;
  final double opacity;

  @override
  String toString() =>
      '_IOS7SiriWaveCurve(attenuation: $attenuation, lineWidth: $lineWidth, opacity: $opacity)';
}

class IOS7SiriWavePainter extends CustomPainter {
  IOS7SiriWavePainter({
    required this.controller,
    required this.frequency,
    required this.options,
  }) : super(repaint: controller);

  final AnimationController controller;
  final int frequency;
  final IOS7Options options;

  static const double _amplitudeFactor = .6;
  static const int _attenuationFactor = 4;
  static const _curves = [
    _IOS7SiriWaveCurve(attenuation: -2, lineWidth: 1, opacity: .1),
    _IOS7SiriWaveCurve(attenuation: -6, lineWidth: 1, opacity: .2),
    _IOS7SiriWaveCurve(attenuation: 4, lineWidth: 1, opacity: .4),
    _IOS7SiriWaveCurve(attenuation: 2, lineWidth: 1, opacity: .6),
    _IOS7SiriWaveCurve(attenuation: 1, lineWidth: 1.5, opacity: 1),
  ];
  static const double _graphX = 2;
  static const double _pixelDepth = .02;
  static const _waveColor = Color(0xFFFFFFFF);

  num _globalAttenuationFactor(num x) => math.pow(
      _attenuationFactor /
          (_attenuationFactor + math.pow(x, _attenuationFactor)),
      _attenuationFactor);

  double _xPos(double i, Size size) =>
      size.width * ((i + _graphX) / (_graphX * 2));

  double _yPos(double i, double attenuation, double maxHeight) =>
      (_amplitudeFactor *
          (_globalAttenuationFactor(i) *
              (maxHeight * options.amplitude) *
              (1 / attenuation) *
              math.sin(frequency * i - controller.value)));

  @override
  void paint(Canvas canvas, Size size) {
    final maxHeight = size.height / 2;

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
        ..strokeWidth = curve.lineWidth
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(IOS7SiriWavePainter oldDelegate) =>
      oldDelegate.options.amplitude != options.amplitude ||
      oldDelegate.frequency != frequency;
}
