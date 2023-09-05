// Copyright (c) 2023, Halil Durmus. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/siri_wave_controller.dart';

/// A custom painter that draws the iOS 9 style Siri waveform.
class IOS9SiriWavePainter extends CustomPainter {
  IOS9SiriWavePainter({
    required this.animationController,
    required this.controller,
  }) : super(repaint: animationController);

  final AnimationController animationController;
  final SiriWaveController controller;

  static const _amplitudeFactor = .8;
  static const _amplitudeRanges = <double>[.3, 1];
  static const _attenuationFactor = 4;
  static const _deadPixel = 2;
  static const _despawnFactor = .02;
  static const _despawnTimeoutRanges = [500, 2000];
  static const _graphX = 25.0;
  static const _noOfCurvesRanges = [2, 5];
  static const _offsetRanges = [-3, 3];
  static const _pixelDepth = .1;
  static const _speedFactor = 1;
  static const _speedRanges = <double>[.5, 1];
  static const _waveColors = [
    Color.fromRGBO(173, 57, 76, 1),
    Color.fromRGBO(48, 220, 155, 1),
    Color.fromRGBO(15, 82, 169, 1),
  ];
  static const _widthRanges = [1, 3];

  final _waves = <String, _IOS9SiriWave>{
    'red': _IOS9SiriWave(color: _waveColors[0]),
    'green': _IOS9SiriWave(color: _waveColors[1]),
    'blue': _IOS9SiriWave(color: _waveColors[2]),
  };

  num _getRandomRange(List<num> e) =>
      e[0] + math.Random().nextDouble() * (e[1] - e[0]);

  void _spawnSingle(int ci, String key) {
    final wave = _waves[key]!;
    wave.phases[ci] = 0;
    wave.amplitudes[ci] = 0;
    wave.despawnTimeouts[ci] =
        _getRandomRange(_despawnTimeoutRanges).toDouble();
    wave.offsets[ci] = _getRandomRange(_offsetRanges).toDouble();
    wave.speeds[ci] = _getRandomRange(_speedRanges).toDouble();
    wave.finalAmplitudes[ci] = _getRandomRange(_amplitudeRanges).toDouble();
    wave.widths[ci] = _getRandomRange(_widthRanges).toDouble();
    wave.verses[ci] = _getRandomRange([-1, 1]).toDouble();
  }

  List<double> _getEmptyArray(int length) => List.filled(length, 0.0);

  void _spawn(String key) {
    final curvesCount = _getRandomRange(_noOfCurvesRanges).floor();
    final wave = _waves[key]!
      ..spawnAt = DateTime.now().millisecondsSinceEpoch
      ..noOfCurves = curvesCount
      ..amplitudes = _getEmptyArray(curvesCount)
      ..despawnTimeouts = _getEmptyArray(curvesCount)
      ..finalAmplitudes = _getEmptyArray(curvesCount)
      ..offsets = _getEmptyArray(curvesCount)
      ..phases = _getEmptyArray(curvesCount)
      ..speeds = _getEmptyArray(curvesCount)
      ..verses = _getEmptyArray(curvesCount)
      ..widths = _getEmptyArray(curvesCount);

    for (var ci = 0; ci < wave.noOfCurves; ci++) {
      _spawnSingle(ci, key);
    }
  }

  num _globalAttenuationFactor(double x) => math.pow(
      _attenuationFactor / (_attenuationFactor + math.pow(x, 2)),
      _attenuationFactor);

  num _sin(double x, double phase) => math.sin(x - phase);

  num _yRelativePos(double i, String key) {
    final wave = _waves[key]!;
    var y = .0;

    for (var ci = 0; ci < wave.noOfCurves; ci++) {
      // Generate a static t so that each curve is distant from each other
      var t = 4 * (-1 + (ci / (wave.noOfCurves - 1)) * 2);
      // but add a dynamic offset
      t += wave.offsets[ci];

      final k = 1 / wave.widths[ci];
      final x = i * k - t;

      y += (wave.amplitudes[ci] *
              _sin(wave.verses[ci] * x, wave.phases[ci]) *
              _globalAttenuationFactor(x))
          .abs();
    }

    // Divide with noOfCurves so that y <= 1
    return y / wave.noOfCurves;
  }

  double _yPos(double i, String key, double maxHeight) =>
      _amplitudeFactor *
      maxHeight *
      controller.amplitude *
      _yRelativePos(i, key) *
      _globalAttenuationFactor((i / _graphX) * 2);

  double _xPos(double i, double width) =>
      width * ((i + _graphX) / (_graphX * 2));

  @override
  void paint(Canvas canvas, Size size) {
    final maxHeight = size.height / 2;

    // Interpolate amplitude and speed values.
    controller.lerp();

    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.white);

    for (final entry in _waves.entries) {
      final wave = entry.value;
      if (wave.spawnAt == 0) {
        _spawn(entry.key);
      }

      for (var ci = 0; ci < wave.noOfCurves; ci++) {
        if (wave.spawnAt + wave.despawnTimeouts[ci] <=
            DateTime.now().millisecondsSinceEpoch) {
          wave.amplitudes[ci] -= _despawnFactor;
        } else {
          wave.amplitudes[ci] += _despawnFactor;
        }

        wave.amplitudes[ci] = math.min(
            math.max(wave.amplitudes[ci], 0), wave.finalAmplitudes[ci]);
        wave.phases[ci] = (wave.phases[ci] +
                controller.speed * wave.speeds[ci] * _speedFactor) %
            (2 * math.pi);
      }

      var maxY = double.negativeInfinity;
      var minX = double.infinity;

      // Create two opposite waves
      for (final sign in [1, -1]) {
        final path = Path()..moveTo(0, maxHeight);
        for (var i = -_graphX; i <= _graphX; i += _pixelDepth) {
          final x = _xPos(i, size.width);
          final y = _yPos(i, entry.key, maxHeight);
          path.lineTo(x, maxHeight - sign * y);

          minX = math.min(minX, x);
          maxY = math.max(maxY, y);
        }

        path.close();
        final paint = Paint()
          ..blendMode = BlendMode.plus
          ..color = wave.color;
        canvas.drawPath(path, paint);
      }

      if (maxY < _deadPixel && wave.prevMaxY >= maxY) {
        wave.spawnAt = 0;
      }

      wave.prevMaxY = maxY;
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(IOS9SiriWavePainter oldDelegate) =>
      oldDelegate.controller.amplitude != controller.amplitude ||
      oldDelegate.controller.speed != controller.speed;
}

/// Describes the curve properties will be used by [IOS9SiriWavePainter].
class _IOS9SiriWave {
  _IOS9SiriWave({required this.color});

  var amplitudes = <double>[];
  final Color color;
  var despawnTimeouts = <double>[];
  var finalAmplitudes = <double>[];
  int noOfCurves = 0;
  var offsets = <double>[];
  var phases = <double>[];
  double prevMaxY = 0;
  int spawnAt = 0;
  var speeds = <double>[];
  var verses = <double>[];
  var widths = <double>[];
}
