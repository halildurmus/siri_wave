import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'painter_controller.dart';
import 'wave_definition.dart';
import 'wave_painter.dart';

class _WaveData {
  int noOfCurves = 0;
  int spawnAt = 0;
  double prevMaxY = 0;
  List<double> phases = [];
  List<double> offsets = [];
  List<double> speeds = [];
  List<double> finalAmplitudes = [];
  List<double> widths = [];
  List<double> amplitudes = [];
  List<double> despawnTimeouts = [];
  List<double> verses = [];
}

class IOS9SiriWave extends StatefulWidget {
  const IOS9SiriWave({
    Key? key,
    this.amplitude = 1,
    this.speed = .2,
    this.controller,
  }) : super(key: key);

  final double amplitude;
  final double speed;
  final PainterController? controller;

  @override
  _IOS9SiriWaveState createState() => _IOS9SiriWaveState();
}

class _IOS9SiriWaveState extends State<IOS9SiriWave>
    with SingleTickerProviderStateMixin {
  static const List<Color> kColors = [
    Color.fromRGBO(173, 57, 76, 1),
    Color.fromRGBO(48, 220, 155, 1),
    Color.fromRGBO(15, 82, 169, 1),
  ];
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

  final Map<String, _WaveData> _wavesData = {
    'red': _WaveData(),
    'green': _WaveData(),
    'blue': _WaveData(),
  };

  late double _height;
  late double _maxHeight;
  late double _width;
  late AnimationController _animationController;
  late PainterController _painterController;

  @override
  void initState() {
    if (widget.controller == null) {
      _painterController = PainterController();
    } else {
      _painterController = widget.controller!;
    }
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

  void _spawnSingle(int ci, String key) {
    final wave = _wavesData[key]!;
    wave.phases[ci] = 0;
    wave.amplitudes[ci] = 0;

    wave.despawnTimeouts[ci] =
        _getRandomRange(DESPAWN_TIMEOUT_RANGES).toDouble();
    wave.offsets[ci] = _getRandomRange(OFFSET_RANGES).toDouble();
    wave.speeds[ci] = _getRandomRange(SPEED_RANGES).toDouble();
    wave.finalAmplitudes[ci] = _getRandomRange(AMPLITUDE_RANGES).toDouble();
    wave.widths[ci] = _getRandomRange(WIDTH_RANGES).toDouble();
    wave.verses[ci] = _getRandomRange([-1, 1]).toDouble();
  }

  List<double> _getEmptyArray(int n) => List.filled(n, 0);

  void _spawn(String key) {
    final wave = _wavesData[key]!;
    wave.spawnAt = DateTime.now().millisecondsSinceEpoch;

    wave.noOfCurves = _getRandomRange(NOOFCURVES_RANGES).floor();

    wave.phases = _getEmptyArray(wave.noOfCurves);
    wave.offsets = _getEmptyArray(wave.noOfCurves);
    wave.speeds = _getEmptyArray(wave.noOfCurves);
    wave.finalAmplitudes = _getEmptyArray(wave.noOfCurves);
    wave.widths = _getEmptyArray(wave.noOfCurves);
    wave.amplitudes = _getEmptyArray(wave.noOfCurves);
    wave.despawnTimeouts = _getEmptyArray(wave.noOfCurves);
    wave.verses = _getEmptyArray(wave.noOfCurves);

    for (int ci = 0; ci < wave.noOfCurves; ci++) {
      _spawnSingle(ci, key);
    }
  }

  num _globalAttFn(double x) =>
      math.pow(ATT_FACTOR / (ATT_FACTOR + math.pow(x, 2)), ATT_FACTOR);

  num _sin(double x, double phase) => math.sin(x - phase);

  num _yRelativePos(double i, String key) {
    final wave = _wavesData[key]!;
    double y = 0;

    for (int ci = 0; ci < wave.noOfCurves; ci++) {
      // Generate a static T so that each curve is distant from each oterh
      double t = 4 * (-1 + (ci / (wave.noOfCurves - 1)) * 2);
      // but add a dynamic offset
      t += wave.offsets[ci];

      final k = 1 / wave.widths[ci];
      final x = i * k - t;

      y += (wave.amplitudes[ci] *
              _sin(wave.verses[ci] * x, wave.phases[ci]) *
              _globalAttFn(x))
          .abs();
    }

    // Divide for NoOfCurves so that y <= 1
    return y / wave.noOfCurves;
  }

  double _yPos(double i, String key) => (AMPLITUDE_FACTOR *
      _maxHeight *
      widget.amplitude *
      _yRelativePos(i, key) *
      _globalAttFn((i / GRAPH_X) * 2));

  double _xPos(double i) => _width * ((i + GRAPH_X) / (GRAPH_X * 2));

  Color _getColor(String key) {
    if (key == 'red') {
      return kColors.first;
    } else if (key == 'green') {
      return kColors[1];
    }

    return kColors[2];
  }

  void _calc(PainterController drawingController) {
    for (final entry in _wavesData.entries) {
      final wave = entry.value;
      final color = _getColor(entry.key);
      if (wave.spawnAt == 0) {
        _spawn(entry.key);
      }

      for (int ci = 0; ci < wave.noOfCurves; ci++) {
        if (wave.spawnAt + wave.despawnTimeouts[ci] <=
            DateTime.now().millisecondsSinceEpoch) {
          wave.amplitudes[ci] -= DESPAWN_FACTOR;
        } else {
          wave.amplitudes[ci] += DESPAWN_FACTOR;
        }

        wave.amplitudes[ci] = math.min(
            math.max(wave.amplitudes[ci], 0), wave.finalAmplitudes[ci]);
        wave.phases[ci] =
            (wave.phases[ci] + widget.speed * wave.speeds[ci] * SPEED_FACTOR) %
                (2 * math.pi);
      }

      double maxY = double.negativeInfinity;
      double minX = double.infinity;

      // Write two opposite waves
      for (final sign in [1, -1]) {
        final path = Path();
        path.moveTo(0, _maxHeight);
        for (double i = -GRAPH_X; i <= GRAPH_X; i += PIXEL_DEPTH) {
          final x = _xPos(i);
          final y = _yPos(i, entry.key);
          path.lineTo(x, _maxHeight - sign * y);

          minX = math.min(minX, x);
          maxY = math.max(maxY, y);
        }

        path.close();
        drawingController.add(WaveDefinition(color: color, path: path));
      }

      if (maxY < DEAD_PX && wave.prevMaxY > maxY) {
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
        final painter = WavePainter(_painterController, _maxHeight, _width);

        return AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            _calc(_painterController);
            return CustomPaint(painter: painter);
          },
        );
      },
    );
  }
}
