import 'package:flutter/material.dart';

import 'ios_7_siri_wave_painter.dart';

class IOS7SiriWave extends StatefulWidget {
  const IOS7SiriWave({
    Key? key,
    required this.amplitude,
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
  void didUpdateWidget(covariant IOS7SiriWave oldWidget) {
    super.didUpdateWidget(oldWidget);
    // TODO(halildurmus): Handle frequency and speed values
    if (_controller.isAnimating && widget.amplitude == 0) {
      _controller.stop(canceled: false);
    } else if (!_controller.isAnimating && widget.amplitude > 0) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customPaint = CustomPaint(
      painter: IOS7SiriWavePainter(
        amplitude: widget.amplitude,
        frequency: widget.frequency,
        controller: _controller,
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => customPaint,
    );
  }
}
