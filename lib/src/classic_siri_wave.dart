import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'classic_siri_wave_painter.dart';

class ClassicSiriWave extends StatefulWidget {
  const ClassicSiriWave({
    Key? key,
    this.amplitude = .3,
    this.frequency = 6,
    this.speed = .2,
  }) : super(key: key);

  final double amplitude;
  final int frequency;
  final double speed;

  @override
  _ClassicSiriWaveState createState() => _ClassicSiriWaveState();
}

class _ClassicSiriWaveState extends State<ClassicSiriWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _phase = 0;
  bool _shouldUpdatePhase = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      // Since we don't use AnimationController's value in the animation,
      // the duration value does not have any affect on the animation.
      duration: const Duration(seconds: 1),
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
              _phase = (_phase + (math.pi / 2) * widget.speed) % (2 * math.pi);
            }
            _shouldUpdatePhase = true;
            return CustomPaint(
              painter: ClassicSiriWavePainter(
                amplitude: widget.amplitude,
                frequency: widget.frequency,
                phase: _phase,
              ),
            );
          },
        ),
      ),
    );
  }
}
