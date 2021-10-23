import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'ios_7_siri_wave_painter.dart';

class IOS7SiriWave extends StatefulWidget {
  const IOS7SiriWave({
    Key? key,
    this.amplitude = .3,
    this.frequency = 6,
    this.speed = .2,
  }) : super(key: key);

  final double amplitude;
  final int frequency;
  final double speed;

  @override
  _IOS7SiriWaveState createState() => _IOS7SiriWaveState();
}

class _IOS7SiriWaveState extends State<IOS7SiriWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double? _phase;

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

  double _calculatePhase() =>
      (_phase! + (math.pi / 2) * widget.speed) % (2 * math.pi);

  void _initializePhase() {
    if (_phase == null) {
      _phase = 0;
    } else {
      _phase = _calculatePhase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        _initializePhase();
        
        return CustomPaint(
          painter: IOS7SiriWavePainter(
            amplitude: widget.amplitude,
            frequency: widget.frequency,
            phase: _phase!,
          ),
        );
      },
    );
  }
}
