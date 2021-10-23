import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'ios_9_siri_wave_painter.dart';
import 'ios_9_wave.dart';
import 'painter_controller.dart';
import 'support_line_painter.dart';

class _IOS9SiriWave {
  int noOfCurves = 0;
  double prevMaxY = 0;
  int spawnAt = 0;
  List<double> amplitudes = [];
  List<double> despawnTimeouts = [];
  List<double> finalAmplitudes = [];
  List<double> offsets = [];
  List<double> phases = [];
  List<double> speeds = [];
  List<double> verses = [];
  List<double> widths = [];
}

class IOS9SiriWave extends StatefulWidget {
  const IOS9SiriWave({
    Key? key,
    this.amplitude = 1,
    this.speed = .2,
  }) : super(key: key);

  final double amplitude;
  final double speed;

  @override
  _IOS9SiriWaveState createState() => _IOS9SiriWaveState();
}

class _IOS9SiriWaveState extends State<IOS9SiriWave>
    with SingleTickerProviderStateMixin {
  static const double _kAmplitudeFactor = .8;
  static const List<double> _kAmplitudeRanges = [.3, 1];
  static const int _kAttenuationFactor = 4;
  static const int _kDeadPixel = 2;
  static const double _kDespawnFactor = .02;
  static const List<int> _kDespawnTimeoutRanges = [500, 2000];
  static const double _kGraphX = 25;
  static const List<int> _kNoOfCurvesRanges = [2, 5];
  static const List<int> _kOffsetRanges = [-3, 3];
  static const double _kPixelDepth = .02;
  static const int _kSpeedFactor = 1;
  static const List<double> _kSpeedRanges = [.5, 1];
  static const List<Color> _kWaveColors = [
    Color.fromRGBO(173, 57, 76, 1),
    Color.fromRGBO(48, 220, 155, 1),
    Color.fromRGBO(15, 82, 169, 1),
  ];
  static const List<int> _kWidthRanges = [1, 3];

  late double _height;
  late double _maxHeight;
  late double _width;
  late AnimationController _animationController;
  late PainterController _painterController;

  final Map<String, _IOS9SiriWave> _waves = {
    'red': _IOS9SiriWave(),
    'green': _IOS9SiriWave(),
    'blue': _IOS9SiriWave(),
  };

  @override
  void initState() {
    _painterController = PainterController();
    _animationController = AnimationController(
      vsync: this,
      // Since we don't use AnimationController's value in the animation,
      // the duration value does not have any affect on the animation.
      duration: const Duration(seconds: 1),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _painterController.dispose();
    super.dispose();
  }

  num _getRandomRange(List<num> e) =>
      e[0] + math.Random().nextDouble() * (e[1] - e[0]);

  void _spawnSingle(int ci, String key) {
    final wave = _waves[key]!;
    wave.phases[ci] = 0;
    wave.amplitudes[ci] = 0;

    wave.despawnTimeouts[ci] =
        _getRandomRange(_kDespawnTimeoutRanges).toDouble();
    wave.offsets[ci] = _getRandomRange(_kOffsetRanges).toDouble();
    wave.speeds[ci] = _getRandomRange(_kSpeedRanges).toDouble();
    wave.finalAmplitudes[ci] = _getRandomRange(_kAmplitudeRanges).toDouble();
    wave.widths[ci] = _getRandomRange(_kWidthRanges).toDouble();
    wave.verses[ci] = _getRandomRange([-1, 1]).toDouble();
  }

  List<double> _getEmptyArray(int n) => List.filled(n, 0);

  void _spawn(String key) {
    final wave = _waves[key]!;
    wave.spawnAt = DateTime.now().millisecondsSinceEpoch;
    wave.noOfCurves = _getRandomRange(_kNoOfCurvesRanges).floor();

    wave.amplitudes = _getEmptyArray(wave.noOfCurves);
    wave.despawnTimeouts = _getEmptyArray(wave.noOfCurves);
    wave.finalAmplitudes = _getEmptyArray(wave.noOfCurves);
    wave.offsets = _getEmptyArray(wave.noOfCurves);
    wave.phases = _getEmptyArray(wave.noOfCurves);
    wave.speeds = _getEmptyArray(wave.noOfCurves);
    wave.verses = _getEmptyArray(wave.noOfCurves);
    wave.widths = _getEmptyArray(wave.noOfCurves);

    for (int ci = 0; ci < wave.noOfCurves; ci++) {
      _spawnSingle(ci, key);
    }
  }

  num _globalAttenuationFactor(double x) => math.pow(
      _kAttenuationFactor / (_kAttenuationFactor + math.pow(x, 2)),
      _kAttenuationFactor);

  num _sin(double x, double phase) => math.sin(x - phase);

  num _yRelativePos(double i, String key) {
    final wave = _waves[key]!;
    double y = 0;

    for (int ci = 0; ci < wave.noOfCurves; ci++) {
      // Generate a static t so that each curve is distant from each other
      double t = 4 * (-1 + (ci / (wave.noOfCurves - 1)) * 2);
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

  double _yPos(double i, String key) => (_kAmplitudeFactor *
      _maxHeight *
      widget.amplitude *
      _yRelativePos(i, key) *
      _globalAttenuationFactor((i / _kGraphX) * 2));

  double _xPos(double i) => _width * ((i + _kGraphX) / (_kGraphX * 2));

  Color _getWaveColor(String key) {
    if (!_waves.keys.contains(key)) {
      throw Exception('Invalid key! Valid keys are: ${_waves.keys}');
    }

    if (key == 'red') {
      return _kWaveColors[0];
    } else if (key == 'green') {
      return _kWaveColors[1];
    }

    return _kWaveColors[2];
  }

  void _calculateWaves(PainterController drawingController) {
    for (final entry in _waves.entries) {
      final wave = entry.value;
      final color = _getWaveColor(entry.key);
      if (wave.spawnAt == 0) {
        _spawn(entry.key);
      }

      for (int ci = 0; ci < wave.noOfCurves; ci++) {
        if (wave.spawnAt + wave.despawnTimeouts[ci] <=
            DateTime.now().millisecondsSinceEpoch) {
          wave.amplitudes[ci] -= _kDespawnFactor;
        } else {
          wave.amplitudes[ci] += _kDespawnFactor;
        }

        wave.amplitudes[ci] = math.min(
            math.max(wave.amplitudes[ci], 0), wave.finalAmplitudes[ci]);
        wave.phases[ci] =
            (wave.phases[ci] + widget.speed * wave.speeds[ci] * _kSpeedFactor) %
                (2 * math.pi);
      }

      double maxY = double.negativeInfinity;
      double minX = double.infinity;

      // Create two opposite waves
      for (final sign in [1, -1]) {
        final path = Path();
        path.moveTo(0, _maxHeight);
        for (double i = -_kGraphX; i <= _kGraphX; i += _kPixelDepth) {
          final x = _xPos(i);
          final y = _yPos(i, entry.key);
          path.lineTo(x, _maxHeight - sign * y);

          minX = math.min(minX, x);
          maxY = math.max(maxY, y);
        }

        path.close();
        drawingController.add(IOS9Wave(color: color, path: path));
      }

      if (maxY < _kDeadPixel && wave.prevMaxY >= maxY) {
        wave.spawnAt = 0;
      }

      wave.prevMaxY = maxY;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _height = constraints.maxHeight;
        _maxHeight = _height / 2;
        _width = constraints.maxWidth;
        final painter = IOS9SiriWavePainter(_painterController);

        return AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            _calculateWaves(_painterController);
            return CustomPaint(
              painter: const SupportLinePainter(),
              foregroundPainter: painter,
            );
          },
        );
      },
    );
  }
}
