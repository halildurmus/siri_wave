import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'classic_siri_wave_painter.dart';

class SiriWave extends StatefulWidget {
  const SiriWave({Key? key}) : super(key: key);

  @override
  _SiriWaveState createState() => _SiriWaveState();
}

class _SiriWaveState extends State<SiriWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final double _amplitude = .6;
  double _phase = 0;
  final double _speed = .2;
  bool _shouldUpdatePhase = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      // Since we don't use AnimationController's value in the animation,
      // the duration value does not have any affect on the animation.
      duration: const Duration(seconds: 2),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            if (_shouldUpdatePhase) {
              _phase = (_phase + (math.pi / 2) * _speed) % (2 * math.pi);
            }
            _shouldUpdatePhase = true;
            return CustomPaint(
              painter: ClassicSiriWavePainter(
                amplitude: _amplitude,
                phase: _phase,
              ),
            );
          },
        ),
      ),
    );
  }
}
