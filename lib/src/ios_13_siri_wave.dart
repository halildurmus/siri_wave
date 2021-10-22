import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'painter_controller.dart';
import 'wave_painter.dart';

class IOS13SiriWave extends StatefulWidget {
  const IOS13SiriWave({
    Key? key,
    this.amplitude = 1,
    required this.color,
    this.speed = .2,
  }) : super(key: key);

  final double amplitude;
  final Color color;
  final double speed;

  @override
  _IOS13SiriWaveState createState() => _IOS13SiriWaveState();
}

class _IOS13SiriWaveState extends State<IOS13SiriWave> with SingleTickerProviderStateMixin {
  static const double GRAPH_X = 25;
  static const double AMPLITUDE_FACTOR = .8;
  static const int SPEED_FACTOR = 1;
  static const int DEAD_PX = 2;
  static const double PIXEL_DEPTH = .02;
  static const int ATT_FACTOR = 4;
  static const double DESPAWN_FACTOR = .02;
  static const List<int> NOOFCURVES_RANGES = [2, 5];
  static const List<double> AMPLITUDE_RANGES = [.3, 1];
  static const List<int> OFFSET_RANGES = [-3, 3];
  static const List<int> WIDTH_RANGES = [1, 3];
  static const List<double> SPEED_RANGES = [.5, 1];
  static const List<int> DESPAWN_TIMEOUT_RANGES = [500, 2000];

  int _noOfCurves = 0;
  int _spawnAt = 0;
  double _prevMaxY = 0;
  List<double> _phases = [];
  List<double> _offsets = [];
  List<double> _speeds = [];
  List<double> _finalAmplitudes = [];
  List<double> _widths = [];
  List<double> _amplitudes = [];
  List<double> _despawnTimeouts = [];
  List<double> _verses = [];

  late double _height;
  late double _maxHeight;
  late double _width;
  late AnimationController _animationController;
  late PainterController _painterController;

  @override
  void initState() {
    _painterController = PainterController(widget.color);
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
    super.dispose();
  }

  num _getRandomRange(List<num> e) =>
      e[0] + math.Random().nextDouble() * (e[1] - e[0]);

  void _spawnSingle(int ci) {
    _phases[ci] = 0;
    _amplitudes[ci] = 0;

    _despawnTimeouts[ci] = _getRandomRange(DESPAWN_TIMEOUT_RANGES).toDouble();
    _offsets[ci] = _getRandomRange(OFFSET_RANGES).toDouble();
    _speeds[ci] = _getRandomRange(SPEED_RANGES).toDouble();
    _finalAmplitudes[ci] = _getRandomRange(AMPLITUDE_RANGES).toDouble();
    _widths[ci] = _getRandomRange(WIDTH_RANGES).toDouble();
    _verses[ci] = _getRandomRange([-1, 1]).toDouble();
  }

  List<double> _getEmptyArray(int n) => List.filled(n, 0);

  void _spawn() {
    _spawnAt = DateTime.now().millisecondsSinceEpoch;

    _noOfCurves = _getRandomRange(NOOFCURVES_RANGES).floor();

    _phases = _getEmptyArray(_noOfCurves);
    _offsets = _getEmptyArray(_noOfCurves);
    _speeds = _getEmptyArray(_noOfCurves);
    _finalAmplitudes = _getEmptyArray(_noOfCurves);
    _widths = _getEmptyArray(_noOfCurves);
    _amplitudes = _getEmptyArray(_noOfCurves);
    _despawnTimeouts = _getEmptyArray(_noOfCurves);
    _verses = _getEmptyArray(_noOfCurves);

    for (int ci = 0; ci < _noOfCurves; ci++) {
      _spawnSingle(ci);
    }
  }

  num _globalAttFn(double x) =>
      math.pow(ATT_FACTOR / (ATT_FACTOR + math.pow(x, 2)), ATT_FACTOR);

  num _sin(double x, double phase) => math.sin(x - phase);

  num _yRelativePos(double i) {
    double y = 0;

    for (int ci = 0; ci < _noOfCurves; ci++) {
      // Generate a static T so that each curve is distant from each oterh
      double t = 4 * (-1 + (ci / (_noOfCurves - 1)) * 2);
      // but add a dynamic offset
      t += _offsets[ci];

      final k = 1 / _widths[ci];
      final x = i * k - t;

      y += (_amplitudes[ci] * _sin(_verses[ci] * x, _phases[ci]) * _globalAttFn(x))
          .abs();
    }

    // Divide for NoOfCurves so that y <= 1
    return y / _noOfCurves;
  }

  double _yPos(double i) => (AMPLITUDE_FACTOR *
      _maxHeight *
      widget.amplitude *
      _yRelativePos(i) *
      _globalAttFn((i / GRAPH_X) * 2));

  double _xPos(double i) => _width * ((i + GRAPH_X) / (GRAPH_X * 2));

  void _calc(PainterController drawingController) {
    if (_spawnAt == 0) {
      _spawn();
    }

    for (int ci = 0; ci < _noOfCurves; ci++) {
      if (_spawnAt + _despawnTimeouts[ci] <=
          DateTime.now().millisecondsSinceEpoch) {
        _amplitudes[ci] -= DESPAWN_FACTOR;
      } else {
        _amplitudes[ci] += DESPAWN_FACTOR;
      }

      _amplitudes[ci] =
          math.min(math.max(_amplitudes[ci], 0), _finalAmplitudes[ci]);
      _phases[ci] =
          (_phases[ci] + widget.speed * _speeds[ci] * SPEED_FACTOR) % (2 * math.pi);
    }

    double maxY = double.negativeInfinity;
    double minX = double.infinity;

    // Write two opposite waves
    for (final sign in [1, -1]) {
      final path = Path();
      path.moveTo(0, _maxHeight);
      for (double i = -GRAPH_X; i <= GRAPH_X; i += PIXEL_DEPTH) {
        final x = _xPos(i);
        final y = _yPos(i);
        path.lineTo(x, _maxHeight - sign * y);

        minX = math.min(minX, x);
        maxY = math.max(maxY, y);
      }

      path.close();
      drawingController.add(path);
    }

    if (maxY < DEAD_PX && _prevMaxY > maxY) {
      _spawnAt = 0;
    }

    _prevMaxY = maxY;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _height = constraints.maxHeight;
        _maxHeight = _height / 2;
        _width = constraints.maxWidth;
        return AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            _calc(_painterController);
            return CustomPaint(
              painter: WavePainter(_painterController, _maxHeight, _width),
            );
          },
        );
      },
    );
  }
}
