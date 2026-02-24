import 'dart:math' as math;
import 'dart:typed_data';

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
  static const _attenuationFactor = 4.0;
  static const _graphX = 2.0;
  static const _pixelDepth = .02;

  static const _curves = <_Curve>[
    (attenuation: -2, width: 1, opacity: .1),
    (attenuation: -6, width: 1, opacity: .2),
    (attenuation: 4, width: 1, opacity: .4),
    (attenuation: 2, width: 1, opacity: .6),
    (attenuation: 1, width: 1.5, opacity: 1),
  ];

  double _phase = 0;

  // Cached objects
  final List<Paint?> _paints = .filled(_curves.length, null);
  final List<Path> _paths = .generate(_curves.length, (_) => .new());

  Float64List? _attenuationCache;
  var _cachedCount = 0;

  Paint _paintFor(int curveIndex, double opacity, Color color) {
    var paint = _paints[curveIndex];
    paint ??= _paints[curveIndex] = .new()
      ..strokeWidth = _curves[curveIndex].width
      ..style = .stroke
      ..strokeCap = .round
      ..strokeJoin = .round;
    paint.color = color.withValues(alpha: opacity);
    return paint;
  }

  // Fast x⁴ attenuation
  double _attenuation(double x) {
    final ax = x.abs();
    final x2 = ax * ax;
    final x4 = x2 * x2;
    final ratio = _attenuationFactor / (_attenuationFactor + x4);
    final r2 = ratio * ratio;
    return r2 * r2;
  }

  void _ensureCache(int count) {
    if (_cachedCount == count) return;

    _cachedCount = count;
    _attenuationCache = .new(count + 1);

    for (var s = 0; s <= count; s++) {
      final i = -_graphX + s * _pixelDepth;
      _attenuationCache![s] = _attenuation(i);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Size(:height, :width) = size;
    final maxHeight = height * .5;
    final baseY = maxHeight;

    controller.lerp();

    final freq = controller.frequency;
    final amp = controller.amplitude;
    final speed = controller.speed;
    final color = controller.color;
    final phase = _phase;

    const step = _pixelDepth;
    final count = ((_graphX * 2) / step).ceil();
    final dx = width / count;

    _ensureCache(count);
    final attenuation = _attenuationCache!;

    for (var c = 0; c < _curves.length; c++) {
      final curve = _curves[c];
      final path = _paths[c]..reset();
      final invAtt = 1 / curve.attenuation;

      double x = 0;
      for (var s = 0; s <= count; s++) {
        final i = -_graphX + s * step;
        final y =
            baseY +
            _amplitudeFactor *
                attenuation[s] *
                maxHeight *
                amp *
                invAtt *
                math.sin(freq * i - phase);

        if (s == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }

        x += dx;
      }

      canvas.drawPath(path, _paintFor(c, curve.opacity, color));
    }

    _phase += (math.pi / 2) * speed;
    if (_phase > math.pi * 2) _phase -= math.pi * 2;
  }

  @override
  bool shouldRepaint(IOS7SiriWaveformPainter old) {
    final o = old.controller;
    return o.amplitude != controller.amplitude ||
        o.frequency != controller.frequency ||
        o.speed != controller.speed;
  }

  @override
  bool shouldRebuildSemantics(IOS7SiriWaveformPainter oldDelegate) => false;
}

typedef _Curve = ({double attenuation, double opacity, double width});
