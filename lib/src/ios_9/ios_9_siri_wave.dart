import 'package:flutter/material.dart';

import 'ios_9_siri_wave_painter.dart';
import 'support_line_painter.dart';

class IOS9SiriWave extends StatefulWidget {
  const IOS9SiriWave({
    Key? key,
    required this.amplitude,
    this.speed = .2,
  })  : assert(amplitude >= 0 && amplitude <= 1),
        assert(speed >= 0 && speed <= 1),
        super(key: key);

  final double amplitude;
  final double speed;

  @override
  _IOS9SiriWaveState createState() => _IOS9SiriWaveState();
}

class _IOS9SiriWaveState extends State<IOS9SiriWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      // Since we don't use AnimationController's value in the animation,
      // the duration value does not have any affect on the animation.
      duration: const Duration(seconds: 1),
    );
    if (widget.amplitude > 0 && widget.speed > 0) {
      _animationController.repeat();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant IOS9SiriWave oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_animationController.isAnimating &&
        (widget.amplitude == 0 || widget.speed == 0)) {
      _animationController.stop(canceled: false);
    } else if (!_animationController.isAnimating &&
        (widget.amplitude > 0 || widget.speed > 0)) {
      _animationController.repeat();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const supportLinePainter = SupportLinePainter();
    final wavePainter = IOS9SiriWavePainter(
      amplitude: widget.amplitude,
      controller: _animationController,
      speed: widget.speed,
    );

    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) {
        final shouldPaint = widget.amplitude > 0 && widget.speed > 0;

        return CustomPaint(
          painter: supportLinePainter,
          foregroundPainter: shouldPaint ? wavePainter : null,
        );
      },
    );
  }
}
