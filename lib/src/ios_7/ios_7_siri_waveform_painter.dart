import 'dart:math' as math;

import 'package:flutter/animation.dart' show AnimationController;
import 'package:flutter/rendering.dart';

import '../models/siri_waveform_controller.dart';

/// A custom painter responsible for rendering an *iOS 7 Siri-style* waveform.
class IOS7SiriWaveformPainter extends CustomPainter {
  /// Creates an instance of [IOS7SiriWaveformPainter].
  ///
  /// The [animationController] is used to synchronize the animation of the
  /// waveform.
  ///
  /// The [controller] contains properties to control the appearance and
  /// behavior of the waveform.
  IOS7SiriWaveformPainter({
    required this.animationController,
    required this.controller,
  }) : super(repaint: animationController);

  final AnimationController animationController;
  final IOS7SiriWaveformController controller;

  static const _amplitudeFactor = .6;
  static const _attenuationFactor = 4;
  static const _curves = <_IOS7SiriWaveformCurve>[
    (attenuation: -2, width: 1, opacity: .1),
    (attenuation: -6, width: 1, opacity: .2),
    (attenuation: 4, width: 1, opacity: .4),
    (attenuation: 2, width: 1, opacity: .6),
    (attenuation: 1, width: 1.5, opacity: 1),
  ];
  static const _graphX = 2.0;
  static const _pixelDepth = .02;

  double _phase = 0;

  num _globalAttenuationFactor(num x) => math.pow(
    _attenuationFactor / (_attenuationFactor + math.pow(x, _attenuationFactor)),
    _attenuationFactor,
  );

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
      // Cycle the graph from -X to +X every pixelDepth and draw the line.
      for (var i = -_graphX; i <= _graphX; i += _pixelDepth) {
        final x = _xPos(i, size);
        final y = maxHeight + _yPos(i, curve.attenuation, maxHeight);
        path.lineTo(x, y);
      }

      final paint =
          Paint()
            // ignore: deprecated_member_use
            ..color = controller.color.withOpacity(curve.opacity)
            ..strokeWidth = curve.width
            ..style = PaintingStyle.stroke;
      canvas.drawPath(path, paint);
    }

    _phase = (_phase + (math.pi / 2) * controller.speed) % (2 * math.pi);
  }

  @override
  bool shouldRepaint(IOS7SiriWaveformPainter oldDelegate) {
    final oldController = oldDelegate.controller;
    return oldController.amplitude != controller.amplitude ||
        oldController.frequency != controller.frequency ||
        oldController.speed != controller.speed;
  }
}

/// Represents the curve properties will be used by [IOS7SiriWaveformPainter].
typedef _IOS7SiriWaveformCurve =
    ({double attenuation, double opacity, double width});
